import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miraa_social_messaging/component/button/common_button.dart';
import 'package:miraa_social_messaging/component/text/common_text.dart';
import 'package:miraa_social_messaging/component/text_field/common_text_field.dart';
import 'package:miraa_social_messaging/utils/constants/app_colors.dart';
import 'package:miraa_social_messaging/utils/extensions/extension.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CommonText(text: "Help & Support")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text:
                    "Have a question or need assistance? Reach out to our support team, and we’ll get back to you as soon as possible.",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryTextColor,
                top: 16,
                bottom: 16,
                right: 16,
                maxLines: 3,
              ).center,
              CommonText(
                text: "Name",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryTextColor,
                top: 16,
                bottom: 16,
                right: 16,
              ).start,
              CommonTextField(hintText: "Enter your name"),
              CommonText(
                text: "Email",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryTextColor,
                top: 16,
                bottom: 16,
                right: 16,
              ).start,
              CommonTextField(hintText: "Enter your email"),
              CommonText(
                text: "Message",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryTextColor,
                top: 16,
                bottom: 16,
                right: 16,
              ).start,
              CommonTextField(hintText: "Enter your message"),
              SizedBox(height: 32.h),
              CommonButton(
                titleText: "Send",
                onTap: () {},
                titleColor: AppColors.white,
                buttonColor: AppColors.primaryColor,
                titleSize: 14,
                buttonRadius: 12,
                buttonHeight: 48,
                buttonWidth: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
