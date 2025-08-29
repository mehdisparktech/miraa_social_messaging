import 'package:flutter/material.dart';
import 'package:miraa_social_messaging/component/image/common_image.dart';
import 'package:miraa_social_messaging/utils/constants/app_images.dart';
import 'package:miraa_social_messaging/utils/extensions/extension.dart';
import '../../../../../../../config/route/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../controller/sign_in_controller.dart';

import '../../../../../../../utils/constants/app_colors.dart';
import '../../../../../../../utils/constants/app_string.dart';
import '../../../../../../../utils/helpers/other_helper.dart';
import '../widgets/do_not_account.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Body Sections Starts here
      body: GetBuilder<SignInController>(
        builder: (controller) {
          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonImage(imageSrc: AppImages.logo, height: 70).center,

                    /// Log In Instruction here
                    CommonText(
                      text: AppString.welcomeBack,
                      fontSize: 28,
                      top: 16,
                      fontWeight: FontWeight.w700,
                    ).center,
                    CommonText(
                      text: AppString.logIntoYourAccount,
                      fontSize: 14,
                      bottom: 20,
                      top: 16,
                      fontWeight: FontWeight.w400,
                    ).center,

                    /// Account Email Input here
                    CommonText(text: AppString.username, bottom: 8),
                    CommonTextField(
                      controller: controller.emailController,
                      prefixIcon: const Icon(Icons.person),
                      hintText: AppString.username,
                      validator: OtherHelper.emailValidator,
                    ),

                    /// Account Password Input here
                    const CommonText(
                      text: AppString.password,
                      bottom: 8,
                      top: 24,
                    ),
                    CommonTextField(
                      controller: controller.passwordController,
                      prefixIcon: const Icon(Icons.lock),
                      isPassword: true,
                      hintText: AppString.password,
                      validator: OtherHelper.passwordValidator,
                    ),

                    /// Forget Password Button here
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                        child: const CommonText(
                          text: "Forgotten Password?",
                          top: 16,
                          bottom: 32,
                          color: AppColors.yellow,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    /// Submit Button here
                    CommonButton(
                      titleText: AppString.signIn,
                      isLoading: controller.isLoading,
                      onTap: controller.signInUser,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar:
          /// Account Creating Instruction here
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: const DoNotHaveAccount(),
          ),
    );
  }
}
