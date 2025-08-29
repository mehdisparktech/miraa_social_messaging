import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miraa_social_messaging/utils/constants/app_colors.dart';
import '../../../../../../../utils/extensions/extension.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../controller/forget_password_controller.dart';
import '../../../../../../../utils/helpers/other_helper.dart';

class CreatePassword extends StatelessWidget {
  CreatePassword({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App Bar Section starts here
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
        ),
      ),

      /// Body Section starts here
      body: GetBuilder<ForgetPasswordController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: "Set New Password",
                    fontSize: 28,
                    top: 16,
                    fontWeight: FontWeight.w700,
                  ).center,
                  CommonText(
                    text: "Choose a strong password to keep your account safe",
                    fontSize: 14,
                    bottom: 20,
                    top: 16,
                    maxLines: 2,
                    left: 40,
                    right: 40,
                    color: AppColors.secondaryTextColor,
                    fontWeight: FontWeight.w400,
                  ).center,

                  /// Instruction of Creating New Password

                  /// New Password here
                  CommonText(text: "New Password", bottom: 8),
                  CommonTextField(
                    controller: controller.passwordController,
                    prefixIcon: const Icon(Icons.lock),
                    hintText: "Enter New Password",
                    isPassword: true,
                    validator: OtherHelper.passwordValidator,
                  ),

                  /// Confirm Password here
                  CommonText(text: "Confirm Password", bottom: 8, top: 12),
                  CommonTextField(
                    controller: controller.confirmPasswordController,
                    prefixIcon: const Icon(Icons.lock),
                    hintText: "Re-Enter New Password",
                    validator: (value) => OtherHelper.confirmPasswordValidator(
                      value,
                      controller.passwordController,
                    ),
                    isPassword: true,
                  ),
                  64.height,

                  /// Submit Button here
                  CommonButton(
                    titleText: "Update Password",
                    isLoading: controller.isLoadingReset,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        controller.resetPasswordRepo();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
