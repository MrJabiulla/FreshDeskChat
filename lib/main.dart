import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'chat_app/screen/home_screen.dart';
import 'chat_app/viewmodel/chennel_viewmodel.dart';
import 'chat_app/viewmodel/converstion_viewmodel.dart';
import 'chat_app/viewmodel/user_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  if (Platform.isAndroid) {
    await Firebase.initializeApp();
  }
  runApp(
      GetMaterialApp(
          debugShowCheckedModeBanner: false,
      title: "Chat bot",
          initialBinding: BindingsBuilder(() {
            Get.put(UsersController());
            Get.put(ChannelsController());
            Get.put(ConversationsController());

          }),
      home: HomeScreen()));
}

