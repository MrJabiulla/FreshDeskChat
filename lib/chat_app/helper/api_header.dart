import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiHeaders {
  ApiHeaders._();

  static String get token => dotenv.env['CHAT_API_KEY'] ?? "";

  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
}
