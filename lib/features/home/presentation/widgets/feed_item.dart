import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miraa_social_messaging/utils/extensions/extension.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/image/common_avatar.dart';
import '../../../../utils/constants/app_colors.dart';

class FeedItem extends StatelessWidget {
  final String senderName;
  final String receiverName;
  final String message;
  final String timeAgo;
  final int likes;
  final int comments;
  final int shares;
  final Color senderAvatarColor;
  final Color receiverAvatarColor;

  const FeedItem({
    super.key,
    required this.senderName,
    required this.receiverName,
    required this.message,
    required this.timeAgo,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.senderAvatarColor,
    required this.receiverAvatarColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //height: 182.h,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Color(0xFF000804),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(17.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header with two users and arrow
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Sender (Angel)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonAvatar(
                      name: senderName,
                      radius: 16,
                      backgroundColor: senderAvatarColor,
                      textColor: AppColors.white,
                      fontSize: 12,
                    ),
                    SizedBox(width: 12.w),
                    CommonText(
                      text: senderName,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                16.width,

                // Arrow
                Icon(
                  Icons.arrow_forward,
                  color: AppColors.primaryColor,
                  size: 24.sp,
                ),
                16.width,

                // Receiver (Shawn)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonAvatar(
                      name: receiverName,
                      radius: 16,
                      backgroundColor: receiverAvatarColor,
                      textColor: AppColors.white,
                      fontSize: 12,
                    ),
                    SizedBox(width: 12.w),
                    CommonText(
                      text: receiverName,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Message container with green border
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                // Gradient background with glow effect
                // gradient: LinearGradient(
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                //   colors: [
                //     Color(0xFF027348).withOpacity(0.15), // Soft glow
                //     Color(0xFF01100A),
                //   ],
                // ),
                borderRadius: BorderRadius.circular(8.r),
                // Left border only
                border: Border(
                  left: BorderSide(
                    width: 4.w,
                    color: Color(0xFF027348), // Primary color
                  ),
                ),
              ),
              child: CommonText(
                text:
                    'Your kindness creates ripples that reach farther than you\'ll ever know. Keep shining! 🌟',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.body,
                maxLines: 3,
                // Line height for relaxed spacing
              ),
            ),

            SizedBox(height: 16.h),

            // Actions and time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    _buildActionButton(
                      icon: Icons.favorite_border,
                      count: likes,
                      onTap: () {},
                    ),
                    SizedBox(width: 16.w),
                    _buildActionButton(
                      icon: Icons.chat_bubble_outline,
                      count: comments,
                      onTap: () {},
                    ),
                    SizedBox(width: 16.w),
                    _buildActionButton(
                      icon: Icons.share_outlined,
                      count: shares,
                      onTap: () {},
                    ),
                  ],
                ),
                CommonText(
                  text: timeAgo,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: AppColors.body,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required int count,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: AppColors.textColor),
          SizedBox(width: 8.w),
          CommonText(
            text: count.toString().padLeft(2, '0'),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.textColor,
          ),
        ],
      ),
    );
  }
}
