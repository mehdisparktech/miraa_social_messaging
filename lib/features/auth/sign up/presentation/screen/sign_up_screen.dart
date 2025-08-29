import 'package:flutter/material.dart';
import 'package:miraa_social_messaging/utils/constants/app_colors.dart';
import '../../../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../controller/sign_up_controller.dart';
import '../widget/already_accunt_rich_text.dart';
import '../widget/sign_up_all_filed.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App Bar Section Starts Here
      appBar: AppBar(),

      /// Body Section Starts Here
      body: GetBuilder<SignUpController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: controller.signUpFormKey,
              child: Column(
                children: [
                  /// Sign UP Instructions here
                  CommonText(
                    text: "Create Your Account",
                    fontSize: 28,
                    top: 16,
                    fontWeight: FontWeight.w700,
                  ).center,
                  CommonText(
                    text:
                        "Spread kindness, inspire others, and be part of a positive community.",
                    fontSize: 14,
                    bottom: 20,
                    top: 16,
                    maxLines: 2,
                    left: 40,
                    right: 40,
                    color: AppColors.secondaryTextColor,
                    fontWeight: FontWeight.w400,
                  ).center,

                  /// All Text Filed here
                  SignUpAllField(controller: controller),

                  16.height,

                  /// Submit Button Here
                  CommonButton(
                    titleText: "Create Account",
                    isLoading: controller.isLoading,
                    onTap: controller.signUpUser,
                  ),
                  24.height,

                  ///  Sign In Instruction here
                  const AlreadyAccountRichText(),
                  30.height,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
