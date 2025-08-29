import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/image/common_avatar.dart';
import '../../../../utils/constants/app_colors.dart';

class FeedItem extends StatelessWidget {
  final String name;
  final String username;
  final String message;
  final String timeAgo;
  final int likes;
  final int comments;
  final int shares;
  final Color avatarColor;

  const FeedItem({
    super.key,
    required this.name,
    required this.username,
    required this.message,
    required this.timeAgo,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.avatarColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CommonAvatar(
                name: name,
                radius: 16,
                backgroundColor: avatarColor,
                textColor: AppColors.white,
                fontSize: 12,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CommonText(
                          text: name,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(width: 4.w),
                        Container(
                          width: 4.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryTextColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        CommonText(
                          text: username,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CommonText(
                text: timeAgo,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryTextColor,
                textAlign: TextAlign.right,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          CommonText(
            text: message,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textColor,
            textAlign: TextAlign.left,
            maxLines: 3,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              _buildActionButton(
                icon: Icons.favorite_border,
                count: likes,
                onTap: () {
                  // Handle like
                },
              ),
              SizedBox(width: 24.w),
              _buildActionButton(
                icon: Icons.chat_bubble_outline,
                count: comments,
                onTap: () {
                  // Handle comment
                },
              ),
              SizedBox(width: 24.w),
              _buildActionButton(
                icon: Icons.share_outlined,
                count: shares,
                onTap: () {
                  // Handle share
                },
              ),
            ],
          ),
        ],
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
        children: [
          Icon(icon, size: 18.sp, color: AppColors.secondaryTextColor),
          SizedBox(width: 4.w),
          CommonText(
            text: count.toString(),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryTextColor,
          ),
        ],
      ),
    );
  }
}
