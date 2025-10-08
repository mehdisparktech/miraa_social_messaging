import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/item/user_list_item.dart';
import '../controller/likes_controller.dart';
import '../../../../utils/enum/enum.dart';

class LikesScreen extends GetView<LikesController> {
  final String postId;
  final int totalLikes;

  const LikesScreen({
    super.key,
    required this.postId,
    required this.totalLikes,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize the controller when the screen is built
    controller.initialize(postId, totalLikes);

    return Scaffold(
      appBar: _buildAppBar(context, controller),
      body: Obx(() => _buildBody(controller)),
    );
  }

  Widget _buildBody(LikesController controller) {
    switch (controller.status.value) {
      case Status.loading:
        return const Center(child: CircularProgressIndicator());

      case Status.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: AppColors.red, size: 48.sp),
              SizedBox(height: 16.h),
              CommonText(
                text: controller.errorMessage.value,
                fontSize: 16,
                color: AppColors.textColor,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () => controller.fetchReactions(),
                child: const Text('Retry'),
              ),
            ],
          ),
        );

      case Status.completed:
        return Column(
          children: [
            _buildLikesHeader(controller),
            Expanded(child: _buildUsersList(controller)),
          ],
        );
    }
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    LikesController controller,
  ) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.textColor, size: 24.sp),
        onPressed: () {
          controller.clear();
          Navigator.pop(context);
        },
      ),
      title: CommonText(
        text: 'Likes',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textColor,
      ),
      centerTitle: true,
      actions: [
        // Refresh button
        IconButton(
          icon: Icon(Icons.refresh, color: AppColors.textColor, size: 24.sp),
          onPressed: () => controller.refreshReactions(),
        ),
      ],
    );
  }

  Widget _buildLikesHeader(LikesController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          Icon(Icons.favorite, color: AppColors.red, size: 20.sp),
          SizedBox(width: 12.w),
          CommonText(
            text: '${controller.totalLikes.value} people liked this message',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.body,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget _buildUsersList(LikesController controller) {
    if (controller.reactions.isEmpty) {
      return Center(
        child: CommonText(
          text: 'No likes yet',
          fontSize: 16,
          color: AppColors.body,
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: () => controller.refreshReactions(),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: controller.reactions.length,
        separatorBuilder: (context, index) => SizedBox(height: 10.h),
        itemBuilder: (context, index) {
          final reaction = controller.reactions[index];
          return Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: UserListItem(
              userName: controller.getUserDisplayName(reaction),
              userHandle: controller.getUserHandle(reaction),
              avatarColor: controller.getAvatarColor(reaction.user.id),
              onTap: () {
                // Handle user profile navigation
                // You can navigate to user profile here using reaction.user.id
              },
            ),
          );
        },
      ),
    );
  }
}
