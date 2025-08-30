import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miraa_social_messaging/utils/constants/app_icons.dart';
import '../../utils/constants/app_colors.dart';
import '../text/common_text.dart';
import '../image/common_avatar.dart';
import '../button/action_button.dart';

class CommentItem extends StatelessWidget {
  final String userName;
  final String comment;
  final String timeAgo;
  final int likes;
  final Color avatarColor;
  final bool isLiked;
  final VoidCallback? onLikeTap;

  const CommentItem({
    super.key,
    required this.userName,
    required this.comment,
    required this.timeAgo,
    required this.likes,
    required this.avatarColor,
    this.isLiked = false,
    this.onLikeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          CommonAvatar(
            name: userName,
            radius: 20,
            backgroundColor: avatarColor,
            textColor: AppColors.white,
            fontSize: 14,
          ),

          SizedBox(width: 12.w),

          // Comment content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User name and time
                Row(
                  children: [
                    CommonText(
                      text: userName,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor,
                    ),
                    SizedBox(width: 8.w),
                    CommonText(
                      text: '• $timeAgo',
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: AppColors.body,
                    ),
                  ],
                ),

                SizedBox(height: 4.h),

                // Comment text
                CommonText(
                  text: comment,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.body,
                  maxLines: 10,
                  textAlign: TextAlign.left,
                ),

                SizedBox(height: 12.h),

                // Like button
                ActionButton(
                  iconImage: isLiked ? AppIcons.love : AppIcons.love,
                  count: likes,
                  onTap: onLikeTap ?? () {},
                  isActive: isLiked,
                  activeColor: AppColors.red,
                  iconSize: 14,
                  fontSize: 11,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
