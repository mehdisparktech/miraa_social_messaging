import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../services/api/api_service.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/enum/enum.dart';
import '../../data/model/reaction_model.dart';

class LikesController extends GetxController {
  /// Api status check here
  Rx<Status> status = Status.loading.obs;

  /// List of reactions/users who liked the post
  RxList<ReactionModel> reactions = <ReactionModel>[].obs;

  /// Error message
  RxString errorMessage = ''.obs;

  /// Post ID for which we're fetching likes
  String? postId;

  /// Total likes count
  RxInt totalLikes = 0.obs;

  /// Initialize controller with post ID
  void initialize(String postId, int totalLikes) {
    this.postId = postId;
    this.totalLikes.value = totalLikes;
    fetchReactions();
  }

  /// Fetch reactions/likes from API
  Future<void> fetchReactions() async {
    if (postId == null) {
      errorMessage.value = 'Post ID is required';
      status.value = Status.error;
      return;
    }

    status.value = Status.loading;

    try {
      final response = await ApiService.get(
        '${ApiEndPoint.reactions}/list/$postId',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        reactions.value = data
            .map((json) => ReactionModel.fromJson(json))
            .toList();
        totalLikes.value = reactions.length;
        status.value = Status.completed;
      } else {
        errorMessage.value = response.message;
        status.value = Status.error;
        Utils.errorSnackBar(response.statusCode, response.message);
      }
    } catch (e) {
      errorMessage.value = 'Failed to fetch reactions: ${e.toString()}';
      status.value = Status.error;
      Utils.errorSnackBar(500, errorMessage.value);
    }
  }

  /// Refresh reactions (pull to refresh)
  Future<void> refreshReactions() async {
    await fetchReactions();
  }

  /// Get user display name from reaction
  String getUserDisplayName(ReactionModel reaction) {
    return reaction.user.fullName;
  }

  /// Get user handle/username from reaction
  String getUserHandle(ReactionModel reaction) {
    return '@${reaction.user.firstName.toLowerCase()}';
  }

  /// Get avatar color based on user ID (consistent colors)
  Color getAvatarColor(String userId) {
    final colors = [
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.green,
      Colors.red,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
      Colors.cyan,
      Colors.amber,
    ];

    // Generate consistent color based on user ID hash
    final hash = userId.hashCode;
    return colors[hash.abs() % colors.length];
  }

  /// Clear controller data
  void clear() {
    reactions.clear();
    postId = null;
    totalLikes.value = 0;
    errorMessage.value = '';
    status.value = Status.loading;
  }

  /// Controller cleanup
  @override
  void onClose() {
    clear();
    super.onClose();
  }
}
