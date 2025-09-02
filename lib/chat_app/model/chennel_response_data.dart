class ChannelsResponse {
  final List<Channel> channels;
  final Pagination pagination;
  final Links links;

  ChannelsResponse({
    required this.channels,
    required this.pagination,
    required this.links,
  });

  factory ChannelsResponse.fromJson(Map<String, dynamic> json) {
    return ChannelsResponse(
      channels: (json['channels'] as List)
          .map((e) => Channel.fromJson(e))
          .toList(),
      pagination: Pagination.fromJson(json['pagination']),
      links: Links.fromJson(json['links']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'channels': channels.map((e) => e.toJson()).toList(),
      'pagination': pagination.toJson(),
      'links': links.toJson(),
    };
  }
}

class Channel {
  final String id;
  final IconData icon;
  final String updatedTime;
  final bool enabled;
  final bool isPublic;
  final String name;
  final List<String> tags;
  final WelcomeMessage welcomeMessage;
  final String source;

  Channel({
    required this.id,
    required this.icon,
    required this.updatedTime,
    required this.enabled,
    required this.isPublic,
    required this.name,
    required this.tags,
    required this.welcomeMessage,
    required this.source,
  });

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      id: json['id'],
      icon: IconData.fromJson(json['icon'] ?? {}),
      updatedTime: json['updated_time'],
      enabled: json['enabled'],
      isPublic: json['public'],
      name: json['name'],
      tags: List<String>.from(json['tags'] ?? []),
      welcomeMessage: WelcomeMessage.fromJson(json['welcome_message']),
      source: json['source'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'icon': icon.toJson(),
      'updated_time': updatedTime,
      'enabled': enabled,
      'public': isPublic,
      'name': name,
      'tags': tags,
      'welcome_message': welcomeMessage.toJson(),
      'source': source,
    };
  }
}

class IconData {
  IconData();

  factory IconData.fromJson(Map<String, dynamic> json) {
    return IconData();
  }

  Map<String, dynamic> toJson() => {};
}

class WelcomeMessage {
  final List<MessagePart> messageParts;
  final String messageType;
  final bool restrictResponse;
  final bool botsPrivateNote;
  final bool isBotsInput;

  WelcomeMessage({
    required this.messageParts,
    required this.messageType,
    required this.restrictResponse,
    required this.botsPrivateNote,
    required this.isBotsInput,
  });

  factory WelcomeMessage.fromJson(Map<String, dynamic> json) {
    return WelcomeMessage(
      messageParts: (json['message_parts'] as List)
          .map((e) => MessagePart.fromJson(e))
          .toList(),
      messageType: json['message_type'],
      restrictResponse: json['restrictResponse'],
      botsPrivateNote: json['botsPrivateNote'],
      isBotsInput: json['isBotsInput'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message_parts': messageParts.map((e) => e.toJson()).toList(),
      'message_type': messageType,
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

class Pagination {
  final int totalItems;
  final int totalPages;
  final int currentPage;
  final int itemsPerPage;

  Pagination({
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
    required this.itemsPerPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalItems: json['total_items'],
      totalPages: json['total_pages'],
      currentPage: json['current_page'],
      itemsPerPage: json['items_per_page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_items': totalItems,
      'total_pages': totalPages,
      'current_page': currentPage,
      'items_per_page': itemsPerPage,
    };
  }
}

class Links {
  final PageLink firstPage;
  final PageLink lastPage;

  Links({required this.firstPage, required this.lastPage});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      firstPage: PageLink.fromJson(json['first_page']),
      lastPage: PageLink.fromJson(json['last_page']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_page': firstPage.toJson(),
      'last_page': lastPage.toJson(),
    };
  }
}

class PageLink {
  final String href;
  final String rel;
  final String type;

  PageLink({required this.href, required this.rel, required this.type});

  factory PageLink.fromJson(Map<String, dynamic> json) {
    return PageLink(
      href: json['href'],
      rel: json['rel'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'href': href,
      'rel': rel,
      'type': type,
    };
  }
}
