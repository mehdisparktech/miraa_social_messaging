import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miraa_social_messaging/component/image/common_image.dart';
import 'package:miraa_social_messaging/utils/constants/app_icons.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/image/common_avatar.dart';
import '../../../../utils/constants/app_colors.dart';

class InboxFeedItem extends StatelessWidget {
  final String senderName;
  final String message;
  final String timeAgo;
  final Color senderAvatarColor;
  final String? postId;
  final bool isShared;

  const InboxFeedItem({
    super.key,
    required this.senderName,
    required this.message,
    required this.timeAgo,
    required this.senderAvatarColor,
    this.postId,
    this.isShared = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: AppColors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.borderColor2, width: 1.w),
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(17.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with two users
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

            SizedBox(height: 16.h),

            // Message container with green border
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.massagesBackGroundColor,
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
                text: message,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.body,
                maxLines: 3,
                textAlign: TextAlign.left,
              ),
            ),

            SizedBox(height: 16.h),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: isShared ? AppColors.yellow : AppColors.primaryColor,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonImage(imageSrc: AppIcons.share, size: 16.sp),
                  SizedBox(width: 8.w),
                  CommonText(
                    text: isShared ? "Shared" : "Share to Feed",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: isShared ? AppColors.black : AppColors.white,
                  ),
                ],
              ),
            ),

            // Actions and time
          ],
        ),
      ),
    );
  }
}
