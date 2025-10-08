import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:miraa_social_messaging/config/api/api_end_point.dart';
import 'package:miraa_social_messaging/features/home/data/model/feed_model.dart';
import 'package:miraa_social_messaging/services/api/api_service.dart';
import 'package:miraa_social_messaging/utils/constants/app_colors.dart';
import 'package:miraa_social_messaging/utils/app_utils.dart';

class HomeController extends GetxController {
  final TextEditingController messageController = TextEditingController();

  RxInt currentStreak = 4.obs;
  RxDouble streakProgress = 0.4.obs;

  // Feed data
  RxList<FeedItemModel> feedItems = <FeedItemModel>[].obs;
  RxBool isLoadingFeed = false.obs;
  RxBool isLoadingSend = false.obs;
  RxString feedError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize any data loading here
    Fluttertoast.showToast(
      msg: "Message sent to a random people",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.primaryColor,
      textColor: AppColors.white,
      fontSize: 16.sp,
    );
    // Fetch feed data
    fetchFeedData();
  }

  void sendMessage() async {
    if (messageController.text.trim().isNotEmpty) {
      try {
        String messageText = messageController.text.trim();

        // Create request body according to API specification
        Map<String, String> body = {"message": messageText};

        // Show loading state
        isLoadingSend(true);
        update();

        // Make API call to the specified endpoint
        var response = await ApiService.post(
          ApiEndPoint.sendMessage, // This uses 'message' endpoint
          body: body,
        );

        // Check for successful response according to API specification
        if (response.statusCode == 200 && response.data['success'] == true) {
          // Success - clear the message field
          messageController.clear();

          // Show success message from API response
          Fluttertoast.showToast(
            msg: response.data['message'] ?? "Message sent successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: AppColors.primaryColor,
            textColor: AppColors.white,
            fontSize: 16.sp,
          );

          // Refresh feed data to show the new message
          fetchFeedData();
        } else {
          // Error handling - show API error message
          String errorMessage = response.data['message'] ?? "Failed to send message";
          Utils.errorSnackBar(response.statusCode, errorMessage);
        }
      } catch (e) {
        // Network or other errors
        Utils.errorSnackBar(500, "Failed to send message. Please try again.");
      } finally {
        // Hide loading state
        isLoadingSend(false);
        update();
      }
    } else {
      // Show validation message if text field is empty
      Fluttertoast.showToast(
        msg: "Please write a message before sending",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.red,
        textColor: AppColors.white,
        fontSize: 16.sp,
      );
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

  Future<void> fetchFeedData() async {
    try {
      isLoadingFeed.value = true;
      feedError.value = '';

      final response = await ApiService.get(ApiEndPoint.messageFeed);

      if (response.statusCode == 200) {
        final feedResponse = FeedResponseModel.fromJson(
          Map<String, dynamic>.from(response.data),
        );
        feedItems.value = feedResponse.data.data;
      } else {
        feedError.value = 'Failed to load feed data';
        Fluttertoast.showToast(
          msg: "Failed to load feed data",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.red,
          textColor: AppColors.white,
          fontSize: 14.sp,
        );
      }
    } catch (e) {
      feedError.value = 'Error loading feed: ${e.toString()}';
      Fluttertoast.showToast(
        msg: "Error loading feed data",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.red,
        textColor: AppColors.white,
        fontSize: 14.sp,
      );
    } finally {
      isLoadingFeed.value = false;
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
