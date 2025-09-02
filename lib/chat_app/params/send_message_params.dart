// class SendMessageParams {
//   final String conversationId;
//   final String channelId;
//   final String appId;
//   final String actorId;
//   final String actorType; // "user" or "agent"
//   final List<MessagePartParams> messageParts;
//
//   SendMessageParams({
//     required this.conversationId,
//     required this.channelId,
//     required this.appId,
//     required this.actorId,
//     required this.actorType,
//     required this.messageParts,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       "conversation_id": conversationId,
//       "channel_id": channelId,
//       "app_id": appId,
//       "actor_id": actorId,
//       "actor_type": actorType,
//       "messages": [
//         {
//           "message_parts": messageParts.map((e) => e.toJson()).toList(),
//           "conversation_id": conversationId,
//           "channel_id": channelId,
//           "actor_id": actorId,
//           "actor_type": actorType,
//           "app_id": appId,
//         }
//       ]
//     };
//   }
// }
//
// class MessagePartParams {
//   final TextContent text;
//
//   MessagePartParams({required this.text});
//
//   Map<String, dynamic> toJson() {
//     return {
//       "text": text.toJson(),
//     };
//   }
// }
//
// class TextContent {
//   final String content;
//
//   TextContent({required this.content});
//
//   Map<String, dynamic> toJson() {
//     return {
//       "content": content,
//     };
//   }
// }

class SendMessageParams {
  final String conversationId;
  final String channelId;
  final String appId;
  final String actorId;
  final String actorType; // "user" or "agent"
  final List<MessagePartParams> messageParts;

  SendMessageParams({
    required this.conversationId,
    required this.channelId,
    required this.appId,
    required this.actorId,
    required this.actorType,
    required this.messageParts,
  });

  // For sending message to existing conversation
  Map<String, dynamic> toJson() {
    return {
      "messages": [
        {
          "message_parts": messageParts.map((e) => e.toJson()).toList(),
          "conversation_id": conversationId,
          "channel_id": channelId,
          "actor_id": actorId,
          "actor_type": actorType,
          "app_id": appId,
          "message_type": "normal",
        }
      ]
    };
  }

  // For creating new conversation with initial message (backward compatibility)
  Map<String, dynamic> toCreateConversationJson() {
    return {
      "conversation_id": conversationId,
      "channel_id": channelId,
      "app_id": appId,
      "actor_id": actorId,
      "actor_type": actorType,
      "messages": [
        {
          "message_parts": messageParts.map((e) => e.toJson()).toList(),
          "conversation_id": conversationId,
          "channel_id": channelId,
          "actor_id": actorId,
          "actor_type": actorType,
          "app_id": appId,
        }
      ]
    };
  }
}

class MessagePartParams {
  final TextContent text;

  MessagePartParams({required this.text});

  Map<String, dynamic> toJson() {
    return {
      "text": text.toJson(),
    };
  }
}

class TextContent {
  final String content;

  TextContent({required this.content});

  Map<String, dynamic> toJson() {
    return {
      "content": content,
    };
  }
}
