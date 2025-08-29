import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final TextEditingController messageController = TextEditingController();

  RxInt currentStreak = 4.obs;
  RxDouble streakProgress = 0.4.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize any data loading here
  }

  void sendMessage() {
    if (messageController.text.trim().isNotEmpty) {
      // Handle sending message logic here
      messageController.clear();
      // You can add API call or local storage logic
    }
  }

  void likePost(int postId) {
    // Handle like functionality
  }

  void commentOnPost(int postId) {
    // Handle comment functionality
  }

  void sharePost(int postId) {
    // Handle share functionality
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
