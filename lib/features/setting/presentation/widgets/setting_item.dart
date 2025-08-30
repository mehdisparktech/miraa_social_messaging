import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../component/text/common_text.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({super.key, required this.title, required this.iconDate});

  final String title;
  final IconData iconDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Color(0xFF3F3F3F)),
      ),
      child: Row(
        children: [
          /// show icon here
          Icon(iconDate, color: AppColors.secondaryTextColor),

          /// show Title here
          CommonText(
            text: title,
            color: AppColors.secondaryTextColor,
            left: 12,
          ),
          const Spacer(),

          /// show Icon here
          const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.secondaryTextColor,
          ),
        ],
      ),
    );
  }
}
