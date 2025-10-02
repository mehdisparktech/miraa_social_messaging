import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miraa_social_messaging/utils/constants/app_images.dart';
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
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFF027348)),
                ),
                height: 120.h,
                child: CommonTextField(
                  expands: true,
                  controller: controller.messageController,
                  hintText:
                      "Write an inspiring message to brighten someone's day...",
                  fillColor: AppColors.transparent,
                  borderColor: AppColors.borderColor.withOpacity(0.5),
                  hintTextColor: AppColors.secondaryTextColor,
                  textColor: AppColors.textColor,
                  paddingVertical: 0,
                  borderRadius: 8,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      isIcon: true,
                      iconImage: AppImages.sent,
                      titleText: "Send",
                      titleSize: 16,
                      buttonHeight: 44.h,
                      buttonRadius: 8,
                      onTap: controller.sendMessage,
                      isLoading: controller.isLoadingSend.value,
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
