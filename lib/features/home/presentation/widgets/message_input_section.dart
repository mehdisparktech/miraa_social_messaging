import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/text_field/common_text_field.dart';
import '../../../../component/button/common_button.dart';
import '../../../../utils/constants/app_colors.dart';
import '../controller/home_controller.dart';

class MessageInputSection extends StatelessWidget {
  const MessageInputSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.borderColor.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              CommonTextField(
                controller: controller.messageController,
                hintText:
                    "Write an inspiring message to brighten someone's day...",
                fillColor: AppColors.transparent,
                borderColor: AppColors.borderColor.withOpacity(0.5),
                hintTextColor: AppColors.secondaryTextColor,
                textColor: AppColors.textColor,
                paddingVertical: 16,
                borderRadius: 8,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      titleText: "🔥 Send",
                      titleSize: 16,
                      buttonHeight: 44.h,
                      buttonRadius: 8,
                      onTap: controller.sendMessage,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
