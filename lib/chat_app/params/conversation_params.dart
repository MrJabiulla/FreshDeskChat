class ConversationRequestParams {
  final String status;
  final List<MessageParams> messages;
  final String channelId;
  final PropertiesParams properties;
  final List<UserParams> users;

  ConversationRequestParams({
    required this.status,
    required this.messages,
    required this.channelId,
    required this.properties,
    required this.users,
  });

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'messages': messages.map((msg) => msg.toJson()).toList(),
      'channel_id': channelId,
      'properties': properties.toJson(),
      'users': users.map((user) => user.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'SupportRequestParams(status: $status, messages: $messages, channelId: $channelId, properties: $properties, users: $users)';
  }
}

class MessageParams {
  final List<MessagePartParams> messageParts;
  final String channelId;
  final String messageType;
  final String actorType;
  final String actorId;

  MessageParams({
    required this.messageParts,
    required this.channelId,
    required this.messageType,
    required this.actorType,
    required this.actorId,
  });

  Map<String, dynamic> toJson() {
    return {
      'message_parts': messageParts.map((part) => part.toJson()).toList(),
      'channel_id': channelId,
      'message_type': messageType,
      'actor_type': actorType,
      'actor_id': actorId,
    };
  }

  @override
  String toString() {
    return 'Message(messageParts: $messageParts, channelId: $channelId, messageType: $messageType, actorType: $actorType, actorId: $actorId)';
  }
}

class MessagePartParams {
  final TextContent text;

  MessagePartParams({required this.text});

  Map<String, dynamic> toJson() {
    return {
      'text': text.toJson(),
    };
  }

  @override
  String toString() {
    return 'MessagePart(text: $text)';
  }
}

class TextContent {
  final String content;

  TextContent({required this.content});

  Map<String, dynamic> toJson() {
    return {
      'content': content,
    };
  }

  @override
  String toString() {
    return 'TextContent(content: $content)';
  }
}

class PropertiesParams {
  final String priority;
  final String cfType;
  final String cfRating;
  final List<String> cfSupportedProducts;

  PropertiesParams({
    required this.priority,
    required this.cfType,
    required this.cfRating,
    required this.cfSupportedProducts,
  });

  Map<String, dynamic> toJson() {
    return {
      'priority': priority,
      'cf_type': cfType,
      'cf_rating': cfRating,
      'cf_supported_products': cfSupportedProducts,
    };
  }

  @override
  String toString() {
    return 'Properties(priority: $priority, cfType: $cfType, cfRating: $cfRating, cfSupportedProducts: $cfSupportedProducts)';
  }
}

class UserParams {
  final String id;

  UserParams({required this.id});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }

  @override
  String toString() {
    return 'User(id: $id)';
  }
}