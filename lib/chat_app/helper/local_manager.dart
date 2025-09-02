import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String _conversationIdKey = "conversation_id";

  /// Save Conversation ID
  static Future<void> saveConversationId(String conversationId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_conversationIdKey, conversationId);
    print("+_===-=--=-Conversation ID saved: $conversationId");
  }

  /// Get Saved Conversation ID
  static Future<String?> getConversationId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_conversationIdKey);
  }

  /// Clear Conversation ID
  static Future<void> clearConversationId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_conversationIdKey);
    print("Conversation ID cleared");
  }
}
