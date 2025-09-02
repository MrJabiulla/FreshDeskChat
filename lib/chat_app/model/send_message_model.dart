class SendConverstionModel {
  List<Messages>? messages;
  Link? link;

  SendConverstionModel({this.messages, this.link});

  SendConverstionModel.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
    link = json['link'] != null ? new Link.fromJson(json['link']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    if (this.link != null) {
      data['link'] = this.link!.toJson();
    }
    return data;
  }
}

class Messages {
  bool? botsInput;
  List<MessageParts>? messageParts;
  String? appId;
  String? actorId;
  String? orgActorId;
  String? id;
  String? channelId;
  String? conversationId;
  String? freshchatConversationId;
  String? freshchatChannelId;
  String? interactionId;
  String? messageType;
  String? actorType;
  String? createdTime;
  String? userId;
  bool? restrictResponse;
  bool? botsPrivateNote;
  bool? isBotsInput;

  Messages(
      {this.botsInput,
        this.messageParts,
        this.appId,
        this.actorId,
        this.orgActorId,
        this.id,
        this.channelId,
        this.conversationId,
        this.freshchatConversationId,
        this.freshchatChannelId,
        this.interactionId,
        this.messageType,
        this.actorType,
        this.createdTime,
        this.userId,
        this.restrictResponse,
        this.botsPrivateNote,
        this.isBotsInput});

  Messages.fromJson(Map<String, dynamic> json) {
    botsInput = json['bots_input'];
    if (json['message_parts'] != null) {
      messageParts = <MessageParts>[];
      json['message_parts'].forEach((v) {
        messageParts!.add(new MessageParts.fromJson(v));
      });
    }
    appId = json['app_id'];
    actorId = json['actor_id'];
    orgActorId = json['org_actor_id'];
    id = json['id'];
    channelId = json['channel_id'];
    conversationId = json['conversation_id'];
    freshchatConversationId = json['freshchat_conversation_id'];
    freshchatChannelId = json['freshchat_channel_id'];
    interactionId = json['interaction_id'];
    messageType = json['message_type'];
    actorType = json['actor_type'];
    createdTime = json['created_time'];
    userId = json['user_id'];
    restrictResponse = json['restrictResponse'];
    botsPrivateNote = json['botsPrivateNote'];
    isBotsInput = json['isBotsInput'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bots_input'] = this.botsInput;
    if (this.messageParts != null) {
      data['message_parts'] =
          this.messageParts!.map((v) => v.toJson()).toList();
    }
    data['app_id'] = this.appId;
    data['actor_id'] = this.actorId;
    data['org_actor_id'] = this.orgActorId;
    data['id'] = this.id;
    data['channel_id'] = this.channelId;
    data['conversation_id'] = this.conversationId;
    data['freshchat_conversation_id'] = this.freshchatConversationId;
    data['freshchat_channel_id'] = this.freshchatChannelId;
    data['interaction_id'] = this.interactionId;
    data['message_type'] = this.messageType;
    data['actor_type'] = this.actorType;
    data['created_time'] = this.createdTime;
    data['user_id'] = this.userId;
    data['restrictResponse'] = this.restrictResponse;
    data['botsPrivateNote'] = this.botsPrivateNote;
    data['isBotsInput'] = this.isBotsInput;
    return data;
  }
}

class MessageParts {
  Text? text;

  MessageParts({this.text});

  MessageParts.fromJson(Map<String, dynamic> json) {
    text = json['text'] != null ? new Text.fromJson(json['text']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.text != null) {
      data['text'] = this.text!.toJson();
    }
    return data;
  }
}

class Text {
  String? content;

  Text({this.content});

  Text.fromJson(Map<String, dynamic> json) {
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    return data;
  }
}

class Link {
  String? rel;
  String? href;

  Link({this.rel, this.href});

  Link.fromJson(Map<String, dynamic> json) {
    rel = json['rel'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rel'] = this.rel;
    data['href'] = this.href;
    return data;
  }
}
