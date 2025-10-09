import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/item/comment_item.dart';
import '../controller/comments_controller.dart';

class CommentsScreen extends StatelessWidget {
  final String postId;
  final int totalComments;

  const CommentsScreen({
    super.key,
    required this.postId,
    required this.totalComments,
  });

  @override
  Widget build(BuildContext context) {
    final CommentsController controller = Get.put(CommentsController());
    controller.initializePost(postId, totalComments);

    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildCommentsHeader(controller),
          Expanded(child: _buildCommentsContent(controller)),
          _buildCommentInput(controller),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.textColor, size: 24.sp),
        onPressed: () => Get.back(),
      ),
      title: CommonText(
        text: 'Comments',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textColor,
      ),
      centerTitle: true,
    );
  }

  Widget _buildCommentsHeader(CommentsController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          Icon(Icons.chat_bubble_outline, color: AppColors.body, size: 20.sp),
          SizedBox(width: 12.w),
          Obx(
            () => CommonText(
              text:
                  '${controller.totalComments.value.toString().padLeft(2, '0')} People Comments on this message',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.body,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsContent(CommentsController controller) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.error.value.isNotEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonText(
                text: controller.error.value,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.red,
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: controller.fetchComments,
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      }

      if (controller.comments.isEmpty) {
        return Center(
          child: CommonText(
            text: 'No comments yet',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.body,
          ),
        );
      }

      return _buildCommentsList(controller);
    });
  }

  Widget _buildCommentsList(CommentsController controller) {
    return Obx(
      () => ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: controller.comments.length,
        separatorBuilder: (context, index) => Divider(
          color: AppColors.borderColor2,
          height: 1,
          indent: 20.w,
          endIndent: 20.w,
        ),
        itemBuilder: (context, index) {
          final comment = controller.comments[index];
          return CommentItem(
            userName: comment.user.fullName,
            comment: comment.content,
            timeAgo: controller.formatTimeAgo(comment.createdAt),
            likes: comment.reactions.length,
            avatarColor: controller.getAvatarColor(comment.user.id),
            isLiked: controller.isLiked.value,
            onLikeTap: () => controller.toggleCommentLike(comment.id),
            onLikeTextTap: () => controller.goToLikes(index, comment.id),
          );
        },
      ),
    );
  }

  Widget _buildCommentInput(CommentsController controller) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Color(0xFF062618),
        border: Border(
          top: BorderSide(color: AppColors.borderColor2, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.borderColor2, width: 1),
              ),
              child: TextField(
                controller: controller.commentController,
                style: TextStyle(color: AppColors.textColor, fontSize: 14.sp),
                decoration: InputDecoration(
                  hintText: 'Write a positive comment',
                  hintStyle: TextStyle(color: AppColors.body, fontSize: 14.sp),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                ),
                maxLines: null,
                enabled: !controller.isPosting.value,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Obx(
            () => GestureDetector(
              onTap: controller.isPosting.value ? null : controller.sendComment,
              child: Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: controller.isPosting.value
                      ? AppColors.body
                      : AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: controller.isPosting.value
                    ? SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.black,
                          ),
                        ),
                      )
                    : Icon(Icons.send, color: AppColors.black, size: 20.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
