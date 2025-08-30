import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants/app_colors.dart';
import '../text/common_text.dart';
import '../image/common_avatar.dart';

class UserListItem extends StatelessWidget {
  final String userName;
  final String userHandle;
  final Color avatarColor;
  final VoidCallback? onTap;

  const UserListItem({
    super.key,
    required this.userName,
    required this.userHandle,
    required this.avatarColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Color(0xFF121215),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Avatar
            CommonAvatar(
              name: userName,
              backgroundColor: avatarColor,
              textColor: AppColors.white,
              fontSize: 16,
            ),

            SizedBox(width: 16.w),

            // User info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: userName,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 2.h),
                  CommonText(
                    text: userHandle,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.body,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
