import 'package:flutter_dotenv/flutter_dotenv.dart';

class FreshchatUrls {
  FreshchatUrls._();

  // Base URLs
  static String get _baseUrl => dotenv.env['FRESHCHAT_BASE_URL'] ?? "";

  static String usersUrls = '$_baseUrl/users';
  static String getUser(String email) => '$_baseUrl/users?email=$email';
  static String channelsUrls = '$_baseUrl/channels';
  static String conversationsUrls = '$_baseUrl/conversations';

  ///new added
  static String sendMessage(String conversationId) {
    return "$_baseUrl/v2/conversations/$conversationId/messages";
  }
  static String putMessage(String conversationId) => '$_baseUrl/conversations/$conversationId/messages';
  static String getMessages(String conversationId) => '$_baseUrl/conversations/$conversationId/messages';

}