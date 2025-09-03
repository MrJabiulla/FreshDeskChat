import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String _conversationIdKey = "conversation_id";

  /// Save Conversation ID
  static Future<void> saveConversationId(String conversationId, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('conversation_id_$userId', conversationId);
    print("-=-==-=-=-=-=Conversation ID saved: $conversationId for user: $userId");
  }

  static Future<String?> getConversationId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('conversation_id_$userId');
  }

  /// Clear Conversation ID
  static Future<void> clearConversationId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_conversationIdKey);
    print("Conversation ID cleared");
  }
}
