import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helper/api_header.dart';
import '../helper/local_manager.dart';
import '../model/conversation_response_model.dart';
import '../urls.dart';
import '../model/get_converstion_model.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';

class ConversationsController extends GetxController {
  bool isLoading = false;
  bool isSending = false;
  List<Message> messagesList = [];
  String? currentConversationId;

  final Set<String> _pendingLocalMessageIds = <String>{};
  ConversationResponse? _currentConversation;
  ConversationResponse? get currentConversation => _currentConversation;

  Future<void> createConversation(Map<String, dynamic> conversationData) async {
    try {
      isSending = true;
      _safeUpdate();

      final url = Uri.parse(FreshchatUrls.conversationsUrls);
      final response = await http.post(
        url,
        headers: ApiHeaders.headers,
        body: json.encode(conversationData),
      );

      print('Create conversation response: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 202 || response.statusCode == 201 || response.statusCode == 200) {
        final data = json.decode(response.body);
        final conversation = ConversationResponse.fromJson(data);
        currentConversationId = conversation.conversationId;

        if (currentConversationId != null) {
          await SharedPrefsHelper.saveConversationId(currentConversationId!);
        }
        print("Current Conversation ID: $currentConversationId");

        // Don't clear messages immediately - let them stay until refresh
        if (conversation.messages.isNotEmpty) {
          // Merge server messages with existing local messages
          _mergeMessages(conversation.messages);
        }

        print('Conversation created with ID: $currentConversationId');
        print('Messages count: ${messagesList.length}');

      } else {
        print('Error creating conversation: ${response.statusCode} ${response.reasonPhrase}');
        throw Exception('Failed to create conversation');
      }
    } catch (e) {
      print('Exception in createConversation: $e');
      Get.snackbar("Error", "Network error occurred", snackPosition: SnackPosition.BOTTOM);
      rethrow;
    } finally {
      isSending = false;
      _safeUpdate();
    }
  }

  void addMessageToList({
    required String text,
    required String actorType,
    required String actorId,
  }) {
    final messageId = 'local_${DateTime.now().millisecondsSinceEpoch}';

    final message = Message(
      messageParts: [
        MessagePart(text: TextContent(content: text))
      ],
      appId: '',
      actorId: actorId,
      orgActorId: '',
      id: messageId,
      channelId: '',
      conversationId: currentConversationId ?? '',
      freshchatConversationId: '',
      freshchatChannelId: '',
      interactionId: '',
      messageType: "normal",
      actorType: actorType,
      createdTime: DateTime.now().toIso8601String(),
      userId: actorId,
      restrictResponse: false,
      botsPrivateNote: false,
      isBotsInput: false,
    );

    _pendingLocalMessageIds.add(messageId);
    messagesList.add(message);
    _sortMessages();
    _safeUpdate();
  }

  void _mergeMessages(List<Message> serverMessages) {
    List<Message> newMessages = [];

    // 1. Add server messages
    newMessages.addAll(serverMessages);

    // 2. Add local messages only if they don't exist in serverMessages
    for (var localMessage in messagesList) {
      if (localMessage.messageParts.isNotEmpty) {
        bool existsInServer = serverMessages.any((serverMsg) =>
        serverMsg.actorId == localMessage.actorId &&
            serverMsg.messageParts.isNotEmpty &&
            serverMsg.messageParts.first.text.content ==
                localMessage.messageParts.first.text.content);

        if (!existsInServer) {
          newMessages.add(localMessage);
        }
      }
    }

    _sortMessages(newMessages);
    messagesList = newMessages;
    _safeUpdate();
  }

  void _sortMessages([List<Message>? messages]) {
    final messagesToSort = messages ?? messagesList;
    messagesToSort.sort((a, b) {
      try {
        final timeA = DateTime.parse(a.createdTime);
        final timeB = DateTime.parse(b.createdTime);
        return timeA.compareTo(timeB);
      } catch (e) {
        return 0;
      }
    });
  }

  // Remove failed local message
  void removeFailedLocalMessage(String text, String actorId) {
    messagesList.removeWhere((message) =>
    _pendingLocalMessageIds.contains(message.id) &&
        message.messageParts.isNotEmpty &&
        message.messageParts.first.text?.content == text &&
        message.actorId == actorId);

    _pendingLocalMessageIds.removeWhere((id) =>
    !messagesList.any((message) => message.id == id));

    _safeUpdate();
  }

  Future<void> getMessages(String conversationId) async {
    try {
      isLoading = true;
      _safeUpdate();

      final url = Uri.parse(FreshchatUrls.getMessages(conversationId));
      final response = await http.get(url, headers: ApiHeaders.headers);

      print('Get messages response: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final getResponse = GetConverstionModel.fromJson(data);

        List<Message> newMessages = [];

        if (getResponse.messages != null) {
          for (var msg in getResponse.messages!) {
            final message = Message(
              messageParts: msg.messageParts?.map((part) => MessagePart(
                  text: TextContent(content: part.text?.content ?? '')
              )).toList() ?? [],
              appId: msg.appId ?? '',
              actorId: msg.actorId ?? '',
              orgActorId: msg.orgActorId ?? '',
              id: msg.id ?? '',
              channelId: msg.channelId ?? '',
              conversationId: msg.conversationId ?? '',
              freshchatConversationId: msg.freshchatConversationId ?? '',
              freshchatChannelId: msg.freshchatChannelId ?? '',
              interactionId: msg.interactionId ?? '',
              messageType: msg.messageType ?? '',
              actorType: msg.actorType ?? '',
              createdTime: msg.createdTime ?? '',
              userId: msg.userId ?? '',
              restrictResponse: msg.restrictResponse ?? false,
              botsPrivateNote: msg.botsPrivateNote ?? false,
              isBotsInput: msg.isBotsInput ?? false,
            );
            newMessages.add(message);
          }
        }

        _mergeMessages(newMessages);
        print('Messages fetched successfully');
        print('Total messages: ${messagesList.length}');

        _safeUpdate();
      } else {
        print('Error fetching messages: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception in getMessages: $e');
    } finally {
      isLoading = false;
      _safeUpdate();
    }
  }

  void clearMessages() {
    messagesList.clear();
    _pendingLocalMessageIds.clear();
    currentConversationId = null;
    isLoading = false;
    isSending = false;
    _safeUpdate();
  }

  void _safeUpdate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      update();
    });
  }

  Future<void> refreshConversation() async {
    if (currentConversationId != null) {
      await getMessages(currentConversationId!);
    }
  }

  @override
  void onClose() {
    // No polling to stop
    super.onClose();
  }
}