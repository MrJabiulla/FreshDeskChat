import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/local_manager.dart';
import '../model/user_response_model.dart';
import '../params/conversation_params.dart';
import '../params/send_message_params.dart' as sendParams;
import '../viewmodel/converstion_viewmodel.dart';

class ChatScreen extends StatefulWidget {
  final UserModel user;
  final String channelID;

  const ChatScreen({
    Key? key,
    required this.user,
    required this.channelID,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Controllers
  final ConversationsController convController = Get.find<ConversationsController>();
  final TextEditingController msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initConversation();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    msgController.dispose();
    super.dispose();
  }

  // Initialization Methods
  Future<void> _initConversation() async {
    final savedId = await SharedPrefsHelper.getConversationId();

    if (savedId != null && savedId.isNotEmpty) {
      convController.currentConversationId = savedId;
      await _loadConversationMessages();
    } else {
      print("No saved conversation found.");
    }
  }

  Future<void> _loadConversationMessages() async {
    try {
      if (convController.currentConversationId != null &&
          convController.currentConversationId!.isNotEmpty) {
        await convController.getMessages(convController.currentConversationId!);
        _scrollToBottom();
      } else {
        print("No conversation ID available to load messages.");
      }
    } catch (e) {
      print("Error loading conversation messages: $e");
      Get.snackbar("Error", "Failed to load conversation messages");
    }
  }

  // Message Handling Methods
  Future<void> _refreshMessages() async {
    if (convController.currentConversationId != null) {
      await convController.getMessages(convController.currentConversationId!);
      _scrollToBottom();
    }
  }

  void sendMessage() {
    final text = msgController.text.trim();
    if (text.isEmpty) return;

    _createNewConversation(text);
    msgController.clear();
  }

  void _createNewConversation(String messageText) {
    // Add message optimistically first
    convController.addMessageToList(
      text: messageText,
      actorType: "user",
      actorId: widget.user.id ?? "unknown_user",
    );

    final message = MessageParams(
      messageParts: [
        MessagePartParams(text: TextContent(content: messageText))
      ],
      channelId: widget.channelID,
      messageType: "normal",
      actorType: "user",
      actorId: widget.user.id ?? "unknown_user",
    );

    final conversationParams = ConversationRequestParams(
      status: "new",
      messages: [message],
      channelId: widget.channelID,
      properties: PropertiesParams(
        priority: "Low",
        cfType: "General Query",
        cfRating: "3",
        cfSupportedProducts: ["Freshchat", "Freshdesk"],
      ),
      users: [UserParams(id: widget.user.id ?? "unknown_user")],
    );

    // Create the conversation
    convController.createConversation(conversationParams.toJson()).then((_) {
      print("Conversation created successfully");
    }).catchError((error) {
      print("Failed to create conversation: $error");
    });

    print("Creating new conversation: $conversationParams");
  }

  // UI Helper Methods
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _getConversationDisplayId() {
    return convController.currentConversationId?.substring(0, 8) ?? 'New';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat with Human"),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "ID: ${_getConversationDisplayId()}...",
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessagesBody()),
          _buildLoadingIndicator(),
          _buildMessageInput(),
        ],
      ),
    );
  }

  // Widget Building Methods
  Widget _buildMessageBubble(dynamic message, bool isUser) {
    final messageText = message.messageParts.isNotEmpty
        ? message.messageParts[0].text.content
        : "No content";

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue[600] : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isUser
                ? const Radius.circular(12)
                : const Radius.circular(4),
            bottomRight: isUser
                ? const Radius.circular(4)
                : const Radius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: isUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              messageText,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              isUser ? "You" : "Agent",
              style: TextStyle(
                color: isUser ? Colors.blue[100] : Colors.grey[600],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyMessageView() {
    return RefreshIndicator(
      onRefresh: _refreshMessages,
      child: ListView(
        children: const [
          SizedBox(height: 200),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  "No messages yet",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(
                  "Start a conversation by sending a message",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 16),
                Text(
                  "Pull down to refresh",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return RefreshIndicator(
      onRefresh: _refreshMessages,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: convController.messagesList.length,
        itemBuilder: (context, index) {
          final message = convController.messagesList[index];
          final isUser = message.actorType == "user";
          return _buildMessageBubble(message, isUser);
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return GetBuilder<ConversationsController>(
      builder: (_) {
        if (convController.isSending) {
          return Container(
            padding: const EdgeInsets.all(8),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                SizedBox(width: 8),
                Text(
                  "Sending...",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: msgController,
              decoration: InputDecoration(
                hintText: "Type your message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.blue.shade300),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: (_) => sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          _buildSendButton(),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    return GetBuilder<ConversationsController>(
      builder: (_) {
        return FloatingActionButton(
          onPressed: convController.isSending ? null : sendMessage,
          mini: true,
          backgroundColor: convController.isSending
              ? Colors.grey.shade300
              : Colors.blue[600],
          child: Icon(
            Icons.send,
            color: convController.isSending
                ? Colors.grey.shade500
                : Colors.white,
            size: 20,
          ),
        );
      },
    );
  }

  Widget _buildMessagesBody() {
    return GetBuilder<ConversationsController>(
      builder: (_) {
        if (convController.messagesList.isNotEmpty) {
          _scrollToBottom();
        }

        if (convController.isLoading && convController.messagesList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (convController.messagesList.isEmpty) {
          return _buildEmptyMessageView();
        }

        return _buildMessagesList();
      },
    );
  }
}