import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miraa_social_messaging/features/home/presentation/screen/likes_screen.dart';
import 'package:miraa_social_messaging/services/storage/storage_services.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../data/model/comment_model.dart';

class CommentsController extends GetxController {
  final TextEditingController commentController = TextEditingController();

  // Observable state variables
  RxList<CommentItemModel> comments = <CommentItemModel>[].obs;
  RxBool isLoading = true.obs;
  RxBool isPosting = false.obs;
  RxString error = ''.obs;
  RxInt totalComments = 0.obs;
  RxBool isLiked = false.obs;

  // Post ID for API calls
  late String postId;

  // Post ID will be set when controller is initialized

  @override
  void onClose() {
    commentController.dispose();
    super.onClose();
  }

  void initializePost(String postId, int initialTotalComments) {
    this.postId = postId;
    totalComments.value = initialTotalComments;
    fetchComments();
  }

  Future<void> fetchComments() async {
    try {
      isLoading.value = true;
      error.value = '';

      final response = await ApiService.get('${ApiEndPoint.comments}/$postId');

      if (response.statusCode == 200) {
        // Parse the response using CommentResponseModel
        final commentResponse = CommentResponseModel.fromJson(
          Map<String, dynamic>.from(response.data),
        );

        // Update the comments list with the parsed data
        comments.value = commentResponse.data;

        // Update total comments from meta data
        totalComments.value = commentResponse.meta.total;

        comments.refresh();
      } else {
        error.value = 'Failed to load comments';

        Fluttertoast.showToast(
          msg: "Failed to load comments",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.red,
          textColor: AppColors.white,
          fontSize: 14.sp,
        );
      }
    } catch (e) {
      error.value = 'Error loading comments: ${e.toString()}';

      Fluttertoast.showToast(
        msg: "Error loading comments",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.red,
        textColor: AppColors.white,
        fontSize: 14.sp,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendComment() async {
    if (commentController.text.trim().isNotEmpty) {
      final content = commentController.text.trim();

      // Clear the input field immediately for better UX
      commentController.clear();

      // Show posting loading state
      isPosting.value = true;

      try {
        // Call the API to post the comment
        final response = await ApiService.post(
          '${ApiEndPoint.comments}/$postId',
          body: {"content": content},
        );

        if (response.statusCode == 201 && response.data['success'] == true) {
          // Comment posted successfully, refresh the comments list
          Fluttertoast.showToast(
            msg: "Comment posted successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: AppColors.primaryColor,
            textColor: AppColors.white,
          );

          // Refresh the comments from API
          fetchComments();
        } else {
          // Show error message
          Fluttertoast.showToast(
            msg: response.data['message'] ?? "Failed to post comment",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: AppColors.primaryColor,
            textColor: AppColors.white,
          );
          fetchComments();

          // Re-enable the input field
          isPosting.value = false;

          // Restore the text to the input field so user can retry
          commentController.text = content;
        }
      } catch (e) {
        // Handle network or other errors
        Fluttertoast.showToast(
          msg: "Failed to post comment. Please try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.red,
          textColor: AppColors.white,
        );

        // Re-enable the input field
        isPosting.value = false;

        // Restore the text to the input field so user can retry
        commentController.text = content;
      }
    }
  }

  Future<void> toggleCommentLike(String index) async {
    // Implement like functionality later
    // For now, just show a toast

    final response = await ApiService.patch(
      '${ApiEndPoint.likeReaction}/$index',
      header: {'Authorization': 'Bearer ${LocalStorage.token}'},
    );

    if (response.statusCode == 200) {
      isLiked.value = !isLiked.value;
      isLiked.refresh();
      Fluttertoast.showToast(
        msg: "Like Successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        textColor: AppColors.white,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Failed to like comment",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.red,
        textColor: AppColors.white,
      );
    }
  }

  void goToLikes(int index, String commentId) {
    Get.to(
      () => LikesScreen(
        postId: commentId,
        totalLikes: comments[index].reactions.length,
      ),
    );
  }

  String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} min${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'now';
    }
  }

  Color getAvatarColor(String userId) {
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.indigo,
      Colors.amber,
    ];

    int hash = userId.hashCode;
    return colors[hash.abs() % colors.length];
  }
}
