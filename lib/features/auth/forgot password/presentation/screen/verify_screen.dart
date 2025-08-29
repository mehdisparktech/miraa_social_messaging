import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miraa_social_messaging/utils/extensions/extension.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../controller/forget_password_controller.dart';
import '../../../../../../../utils/constants/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../../../utils/constants/app_string.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final formKey = GlobalKey<FormState>();

  /// init State here
  @override
  void initState() {
    ForgetPasswordController.instance.startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App Bar Section
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
        ),
      ),

      /// Body Section
      body: GetBuilder<ForgetPasswordController>(
        builder: (controller) => SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CommonText(
                  text: "Verify OTP",
                  fontSize: 28,
                  top: 16,
                  fontWeight: FontWeight.w700,
                ).center,
                CommonText(
                  text:
                      "Enter the 6-digit code we’ve sent to your email ${controller.emailController.text}",
                  fontSize: 14,
                  bottom: 20,
                  top: 16,
                  maxLines: 2,
                  left: 30,
                  right: 30,
                  color: AppColors.secondaryTextColor,
                  fontWeight: FontWeight.w400,
                ).center,
                64.height,

                /// OTP Filed here
                Flexible(
                  flex: 0,
                  child: PinCodeTextField(
                    controller: controller.otpController,
                    validator: (value) {
                      if (value != null && value.length == 6) {
                        return null;
                      } else {
                        return AppString.otpIsInValid;
                      }
                    },
                    autoDisposeControllers: false,
                    cursorColor: AppColors.white,
                    appContext: (context),
                    autoFocus: true,
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 50.h,
                      fieldWidth: 50.w,
                      activeFillColor: AppColors.transparent,
                      selectedFillColor: AppColors.transparent,
                      inactiveFillColor: AppColors.transparent,
                      borderWidth: 0.0,
                      selectedColor: AppColors.white,
                      activeColor: AppColors.textColor,
                      inactiveColor: AppColors.secondaryTextColor,
                    ),
                    length: 6,
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.disabled,
                    enableActiveFill: true,
                  ),
                ),

                /// Resent OTP or show Timer
                GestureDetector(
                  onTap: controller.time == '00:00'
                      ? () {
                          controller.startTimer();
                          controller.forgotPasswordRepo();
                        }
                      : () {},
                  child: CommonText(
                    text: controller.time == '00:00'
                        ? "00:00"
                        : " ${controller.time} ${AppString.minute}",
                    top: 24,
                    bottom: 24,
                    fontSize: 18,
                    color: AppColors.yellow,
                  ),
                ),

                ///  Submit Button here
                CommonButton(
                  titleText: "Continue",
                  isLoading: controller.isLoadingVerify,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      controller.verifyOtpRepo();
                    }
                  },
                ),

                /// Resent OTP or show Timer
                GestureDetector(
                  onTap: controller.time == '00:00'
                      ? () {
                          controller.startTimer();
                          controller.forgotPasswordRepo();
                        }
                      : () {},
                  child: CommonText(
                    text: controller.time == '00:00' ? "Resend OTP" : "",
                    top: 60,
                    bottom: 100,
                    fontSize: 18,
                    color: AppColors.yellow,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
