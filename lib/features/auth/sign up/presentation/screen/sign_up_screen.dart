import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miraa_social_messaging/component/image/common_image.dart';
import 'package:miraa_social_messaging/utils/constants/app_colors.dart';
import 'package:miraa_social_messaging/utils/constants/app_icons.dart';
import 'package:miraa_social_messaging/utils/constants/app_images.dart';
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
    final signUpFormKey = GlobalKey<FormState>();
    return Scaffold(
      /// App Bar Section Starts Here
      appBar: AppBar(),

      /// Body Section Starts Here
      body: GetBuilder<SignUpController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: signUpFormKey,
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
                    bottom: 32,
                    maxLines: 2,
                    left: 15,
                    right: 15,
                    color: AppColors.secondaryTextColor,
                    fontWeight: FontWeight.w400,
                  ).center,

                  /// All Text Filed here
                  SignUpAllField(controller: controller),

                  16.height,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        activeColor: AppColors.yellow,
                        side: const BorderSide(color: AppColors.yellow),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                          side: const BorderSide(
                            color: AppColors.yellow,
                            width: 2,
                          ),
                        ),
                        value: controller.isAgree,
                        onChanged: (value) {
                          controller.isAgree = value ?? false;
                          controller.update();
                        },
                      ),
                      Expanded(
                        child: RichText(
                          maxLines: 3,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "I agree to the ",
                                style: GoogleFonts.poppins(
                                  color: AppColors.textColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: "Terms of Service ",
                                style: GoogleFonts.poppins(
                                  color: AppColors.primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: "and ",
                                style: GoogleFonts.poppins(
                                  color: AppColors.textColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: "Privacy Policy ",
                                style: GoogleFonts.poppins(
                                  color: AppColors.primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  16.height,

                  /// Submit Button Here
                  CommonButton(
                    titleText: "Create Account",
                    isLoading: controller.isLoading,
                    onTap: () => controller.signUpUser(signUpFormKey),
                  ),
                  SizedBox(height: 24.h),
                  CommonImage(imageSrc: AppImages.or, height: 24),
                  SizedBox(height: 24.h),
                  CommonButton(
                    isIcon: true,
                    iconImage: AppIcons.google,
                    titleText: "Sign up with Google",
                    isLoading: controller.isLoading,
                    onTap: () {},
                    buttonColor: AppColors.transparent,
                    titleColor: AppColors.white,
                    borderColor: AppColors.borderColor,
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [AppColors.transparent, AppColors.transparent],
                    ),
                    borderWidth: 2,
                  ),
                  32.height,

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
