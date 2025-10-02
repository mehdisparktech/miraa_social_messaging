import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:miraa_social_messaging/config/api/api_end_point.dart';
import 'package:miraa_social_messaging/services/api/api_service.dart';
import 'package:miraa_social_messaging/utils/constants/app_colors.dart';
import '../../../home/data/model/comment_model.dart';

class CommentsController extends GetxController {
  final TextEditingController commentController = TextEditingController();
  
  final RxList<CommentItemModel> comments = <CommentItemModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;
  final RxInt totalComments = 0.obs;
  final RxBool isPosting = false.obs;
  
  late String postId;

  void initializePostId(String id, int initialTotalComments) {
    postId = id;
    totalComments.value = initialTotalComments;
    fetchComments();
  }

  Future<void> fetchComments() async {
    try {
      isLoading.value = true;
      error.value = '';

      final response = await ApiService.get(
        '${ApiEndPoint.comments}/$postId',
      );

      if (response.statusCode == 200) {
        final commentResponse = CommentResponseModel.fromJson(
          Map<String, dynamic>.from(response.data),
        );
        
        comments.value = commentResponse.data;
        totalComments.value = commentResponse.meta.total;
      } else {
        error.value = 'Failed to load comments';
        
        Fluttertoast.showToast(
          msg: "Failed to load comments",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.red,
          textColor: AppColors.white,
          fontSize: 14,
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
        fontSize: 14,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendComment() async {
    if (commentController.text.trim().isEmpty) return;

    try {
      isPosting.value = true;

      final response = await ApiService.post(
        '${ApiEndPoint.comments}/$postId',
        body: {
          'content': commentController.text.trim(),
        },
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        commentController.clear();
        await fetchComments();
        
        Fluttertoast.showToast(
          msg: "Comment posted successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          textColor: AppColors.white,
          fontSize: 14,
        );
      } else {
        Fluttertoast.showToast(
          msg: response.data['message'] ?? "Failed to post comment",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.red,
          textColor: AppColors.white,
          fontSize: 14,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error posting comment: ${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.red,
        textColor: AppColors.white,
        fontSize: 14,
      );
    } finally {
      isPosting.value = false;
    }
  }

  void toggleCommentLike(int index) {
    Fluttertoast.showToast(
      msg: "Like functionality coming soon!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
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

  @override
  void onClose() {
    commentController.dispose();
    super.onClose();
  }
}