class ConversationResponse {
  final List<Message> messages;
  final String conversationId;
  final int conversationInternalId;
  final String appId;
  final String status;
  final String channelId;
  final String assignedGroupId;
  final int skillId;
  final ConversationProperties properties;
  final String url;
  final String orgContactId;
  final String createdTime;
  final String updatedTime;
  final String userId;

  ConversationResponse({
    required this.messages,
    required this.conversationId,
    required this.conversationInternalId,
    required this.appId,
    required this.status,
    required this.channelId,
    required this.assignedGroupId,
    required this.skillId,
    required this.properties,
    required this.url,
    required this.orgContactId,
    required this.createdTime,
    required this.updatedTime,
    required this.userId,
  });

  factory ConversationResponse.fromJson(Map<String, dynamic> json) {
    return ConversationResponse(
      messages: (json['messages'] as List)
          .map((e) => Message.fromJson(e))
          .toList(),
      conversationId: json['conversation_id'],
      conversationInternalId: json['conversation_internal_id'],
      appId: json['app_id'],
      status: json['status'],
      channelId: json['channel_id'],
      assignedGroupId: json['assigned_group_id'],
      skillId: json['skill_id'],
      properties: ConversationProperties.fromJson(json['properties']),
      url: json['url'],
      orgContactId: json['org_contact_id'],
      createdTime: json['created_time'],
      updatedTime: json['updated_time'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messages': messages.map((e) => e.toJson()).toList(),
      'conversation_id': conversationId,
      'conversation_internal_id': conversationInternalId,
      'app_id': appId,
      'status': status,
      'channel_id': channelId,
      'assigned_group_id': assignedGroupId,
      'skill_id': skillId,
      'properties': properties.toJson(),
      'url': url,
      'org_contact_id': orgContactId,
      'created_time': createdTime,
      'updated_time': updatedTime,
      'user_id': userId,
    };
  }
}

class Message {
  final List<MessagePart> messageParts;
  final String appId;
  final String actorId;
  final String orgActorId;
  final String id;
  final String channelId;
  final String conversationId;
  final String freshchatConversationId;
  final String freshchatChannelId;
  final String interactionId;
  final String messageType;
  final String actorType;
  final String createdTime;
  final String userId;
  final bool restrictResponse;
  final bool botsPrivateNote;
  final bool isBotsInput;

  Message({
    required this.messageParts,
    required this.appId,
    required this.actorId,
    required this.orgActorId,
    required this.id,
    required this.channelId,
    required this.conversationId,
    required this.freshchatConversationId,
    required this.freshchatChannelId,
    required this.interactionId,
    required this.messageType,
    required this.actorType,
    required this.createdTime,
    required this.userId,
    required this.restrictResponse,
    required this.botsPrivateNote,
    required this.isBotsInput,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageParts: (json['message_parts'] as List)
          .map((e) => MessagePart.fromJson(e))
          .toList(),
      appId: json['app_id'],
      actorId: json['actor_id'],
      orgActorId: json['org_actor_id'],
      id: json['id'],
      channelId: json['channel_id'],
      conversationId: json['conversation_id'],
      freshchatConversationId: json['freshchat_conversation_id'],
      freshchatChannelId: json['freshchat_channel_id'],
      interactionId: json['interaction_id'],
      messageType: json['message_type'],
      actorType: json['actor_type'],
      createdTime: json['created_time'],
      userId: json['user_id'],
      restrictResponse: json['restrictResponse'],
      botsPrivateNote: json['botsPrivateNote'],
      isBotsInput: json['isBotsInput'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message_parts': messageParts.map((e) => e.toJson()).toList(),
      'app_id': appId,
      'actor_id': actorId,
      'org_actor_id': orgActorId,
      'id': id,
      'channel_id': channelId,
      'conversation_id': conversationId,
      'freshchat_conversation_id': freshchatConversationId,
      'freshchat_channel_id': freshchatChannelId,
      'interaction_id': interactionId,
      'message_type': messageType,
      'actor_type': actorType,
      'created_time': createdTime,
      'user_id': userId,
      'restrictResponse': restrictResponse,
      'botsPrivateNote': botsPrivateNote,
      'isBotsInput': isBotsInput,
    };
  }
}

class MessagePart {
  final TextContent text;

  MessagePart({required this.text});

  factory MessagePart.fromJson(Map<String, dynamic> json) {
    return MessagePart(text: TextContent.fromJson(json['text']));
  }

  Map<String, dynamic> toJson() => {
    'text': text.toJson(),
  };
}

class TextContent {
  final String content;

  TextContent({required this.content});

  factory TextContent.fromJson(Map<String, dynamic> json) {
    return TextContent(content: json['content']);
  }

  Map<String, dynamic> toJson() => {
    'content': content,
  };
}

class ConversationProperties {
  final String priority;
  final String cfType;

  ConversationProperties({
    required this.priority,
    required this.cfType,
  });

  factory ConversationProperties.fromJson(Map<String, dynamic> json) {
    return ConversationProperties(
      priority: json['priority'],
      cfType: json['cf_type'],
    );
  }

  Map<String, dynamic> toJson() => {
    'priority': priority,
    'cf_type': cfType,
  };
}
