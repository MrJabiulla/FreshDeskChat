import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodel/chennel_viewmodel.dart';
import '../viewmodel/converstion_viewmodel.dart';
import '../viewmodel/user_viewmodel.dart';
import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UsersController usersController = Get.put(UsersController());
  final ChannelsController channelsController = Get.put(ChannelsController());
  String? channelID;

  @override
  void initState() {
    super.initState();
    usersController.getUser(email: "alice.john@email.com");
    channelsController.fetchChannels().then((_) {
      print("Channels loaded: ${channelsController.channelsList.length}");
      for (var channel in channelsController.channelsList) {
        print("Channel: ${channel.name}");
        print("Channel ID: ${channel.id}");
        print("Channel Type: ${channel.enabled}");
        if (channelsController.channelsList.isNotEmpty) {
          channelID = channelsController.channelsList.first.id;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GetBuilder<UsersController>(
              builder: (_) {
                if (usersController.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (usersController.usersList.isEmpty) {
                  return const Text("No user info available");
                }

                final user = usersController.usersList.first;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Name: ${user.firstName} ${user.lastName}", style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 8),
                    Text("Email: ${user.email}", style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text("Phone: ${user.phone}", style: const TextStyle(fontSize: 16)),
                  ],
                );
              },
            ),
            const SizedBox(height: 40),
            GetBuilder<ConversationsController>(
              builder: (_) {
                return ElevatedButton(
                  onPressed: (){
                    Get.to(() => ChatScreen(
                              user: usersController.usersList.first!,
                      chennelID: channelID ?? '',
                            ));
                  },
                  child: const Text("Talk to Expert"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
