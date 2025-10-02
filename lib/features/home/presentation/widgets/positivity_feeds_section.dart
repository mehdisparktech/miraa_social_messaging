import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miraa_social_messaging/features/home/presentation/controller/home_controller.dart';
import 'package:miraa_social_messaging/utils/extensions/extension.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import 'feed_item.dart';

class PositivityFeedsSection extends StatelessWidget {
  const PositivityFeedsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: "Positivity Feeds",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textColor,
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: AppColors.transparent,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColors.borderColor2),
          ),
          child: Obx(() {
            if (controller.isLoadingFeed.value) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (controller.feedError.isNotEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CommonText(
                    text: 'Failed to load feed data',
                    fontSize: 14,
                    color: AppColors.red,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            if (controller.feedItems.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CommonText(
                    text: 'No feed data available',
                    fontSize: 14,
                    color: AppColors.grey,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.feedItems.length,
              separatorBuilder: (context, index) =>
                  Divider(color: AppColors.borderColor2, height: 1),
              itemBuilder: (context, index) {
                final feed = controller.feedItems[index];
                return FeedItem(
                  senderName: feed.sender.fullName,
                  receiverName: feed.receiver.fullName,
                  message: feed.message,
                  timeAgo: feed.createdAt.checkTime,
                  likes: feed.reactionCount,
                  comments: feed.commentCount,
                  shares: feed.isShared ? 1 : 0,
                  senderAvatarColor: _getAvatarColor(feed.sender.id),
                  receiverAvatarColor: _getAvatarColor(feed.receiver.id),
                  postId: feed.id,
                );
              },
            );
          }),
        ),
      ],
    );
  }
}

// Helper function to generate consistent avatar colors based on user ID
Color _getAvatarColor(String userId) {
  final colors = [
    Colors.purple,
    AppColors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.teal,
    Colors.indigo,
    Colors.cyan,
    Colors.brown,
    Colors.pink,
  ];

  // Use hash code to get consistent color for same user ID
  final hash = userId.hashCode;
  return colors[hash.abs() % colors.length];
}
