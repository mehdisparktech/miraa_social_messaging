import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/app_colors.dart';
import '../controller/profile_controller.dart';
import 'feed_item.dart';

class YourFeedsSection extends StatelessWidget {
  const YourFeedsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: AppColors.borderColor2),
              ),
              child: Obx(() {
                if (controller.isLoadingMessages.value) {
                  return Container(
                    height: 200.h,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  );
                }

                if (controller.messagesError.value.isNotEmpty) {
                  return Container(
                    height: 200.h,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: AppColors.red,
                            size: 48.sp,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Failed to load messages',
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            onPressed: () => controller.fetchMessages(),
                            child: Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (controller.messages.isEmpty) {
                  return Container(
                    height: 200.h,
                    child: Center(
                      child: Text(
                        'No messages found',
                        style: TextStyle(
                          color: AppColors.body,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.messages.length,
                  separatorBuilder: (context, index) =>
                      Divider(color: AppColors.borderColor2, height: 1),
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    
                    // Generate consistent colors based on user IDs
                    final senderColors = [
                      Colors.purple,
                      AppColors.red,
                      Colors.blue,
                      Colors.green,
                      Colors.orange,
                      Colors.teal,
                      Colors.indigo,
                      Colors.pink,
                    ];
                    
                    final receiverColors = [
                      AppColors.yellow,
                      Colors.blue,
                      Colors.green,
                      Colors.orange,
                      Colors.purple,
                      Colors.red,
                      Colors.cyan,
                      Colors.amber,
                    ];
                    
                    final senderColorIndex = message.sender.id.hashCode.abs() % senderColors.length;
                    final receiverColorIndex = message.receiver.id.hashCode.abs() % receiverColors.length;
                    
                    // Calculate time ago
                    final now = DateTime.now();
                    final difference = now.difference(message.createdAt);
                    String timeAgo;
                    
                    if (difference.inMinutes < 60) {
                      timeAgo = '${difference.inMinutes} min ago';
                    } else if (difference.inHours < 24) {
                      timeAgo = '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
                    } else {
                      timeAgo = '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
                    }
                    
                    return FeedItem(
                      senderName: message.sender.fullName,
                      receiverName: message.receiver.fullName,
                      message: message.message,
                      timeAgo: timeAgo,
                      likes: message.reactionCount,
                      comments: message.commentCount,
                      shares: message.isShared ? 1 : 0,
                      senderAvatarColor: senderColors[senderColorIndex],
                      receiverAvatarColor: receiverColors[receiverColorIndex],
                      postId: message.id,
                    );
                  },
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
