import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helper/api_header.dart';
import '../model/chennel_response_data.dart';
import '../urls.dart';

class ChannelsController extends GetxController {
  bool isLoading = false;
  List<Channel> channelsList = [];


  // GET all channels
  Future<void> fetchChannels() async {
    try {
      isLoading = true;
      update();

      final url = Uri.parse(FreshchatUrls.channelsUrls);
      final response = await http.get(url,  headers: ApiHeaders.headers,);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final channelsResponse = ChannelsResponse.fromJson(data);
        channelsList = channelsResponse.channels;
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
