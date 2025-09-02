import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helper/api_header.dart';
import '../model/user_response_model.dart';
import '../urls.dart';


class UsersController extends GetxController {
  bool isLoading = false;
  List<UserModel> usersList = [];


  // GET Users by userId
  Future<void> getUser({required String email}) async {
    try {
      isLoading = true;
      update();

      print("Fetching user with email: $email");
      final url = Uri.parse(FreshchatUrls.getUser(email));
      final response = await http.get(url, headers: ApiHeaders.headers);
      print(url);
      print('Response body: ${response.body}');
      print('Status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final usersResponse = UsersResponse.fromJson(data);
        usersList = usersResponse.users ?? [];
        print('Users fetched: ${usersList.length}');
        print('First user: ${usersList.isNotEmpty ? usersList.first.firstName : 'No user'}');

      } else {
        print('Error: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  // POST Create User
  Future<void> createUser(Map<String, dynamic> params) async {
    try {
      isLoading = true;
      update();

      final url = Uri.parse(FreshchatUrls.usersUrls);
      final response = await http.post(
        url,
        headers: ApiHeaders.headers,
        body: json.encode(params),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        final newUser = UserModel.fromJson(data);
        usersList.add(newUser);
      } else {
        print('Error: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading = false;
      update();
    }
  }
}
