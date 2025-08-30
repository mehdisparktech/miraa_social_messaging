import 'package:flutter/material.dart';
import 'package:miraa_social_messaging/utils/extensions/extension.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/text_field/common_text_field.dart';
import '../controller/profile_controller.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/helpers/other_helper.dart';

class EditProfileAllFiled extends StatelessWidget {
  const EditProfileAllFiled({super.key, required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// User Full Name here
        const CommonText(
          text: "First Name",
          fontWeight: FontWeight.w600,
          bottom: 12,
        ),
        CommonTextField(
          controller: controller.firstNameController,
          validator: OtherHelper.validator,
          hintText: "Enter Your First Name",
          prefixIcon: const Icon(Icons.person),
          keyboardType: TextInputType.text,
          fillColor: AppColors.transparent,
        ),
        12.height,

        const CommonText(
          text: "Last Name",
          fontWeight: FontWeight.w600,
          bottom: 12,
        ),
        CommonTextField(
          controller: controller.lastNameController,
          validator: OtherHelper.validator,
          hintText: "Enter Your Last Name",
          prefixIcon: const Icon(Icons.person),
          keyboardType: TextInputType.text,
          fillColor: AppColors.transparent,
        ),
        12.height,

        const CommonText(
          text: "Username",
          fontWeight: FontWeight.w600,
          bottom: 12,
        ),
        CommonTextField(
          controller: controller.usernameController,
          validator: OtherHelper.validator,
          hintText: "Enter Your Username",
          prefixIcon: const Icon(Icons.person),
          keyboardType: TextInputType.text,
          fillColor: AppColors.transparent,
        ),
        12.height,
        const CommonText(
          text: "Email",
          fontWeight: FontWeight.w600,
          bottom: 12,
        ),
        CommonTextField(
          controller: controller.emailController,
          validator: OtherHelper.validator,
          hintText: "Enter Your Email",
          prefixIcon: const Icon(Icons.person),
          keyboardType: TextInputType.text,
          fillColor: AppColors.transparent,
        ),
        12.height,

        /// User Phone number here
        // const CommonText(
        //   text: AppString.contact,
        //   fontWeight: FontWeight.w600,
        //   top: 20,
        //   bottom: 12,
        // ),
        // CommonPhoneNumberTextFiled(
        //   controller: controller.numberController,
        //   countryChange: (value) {
        //     appLog(value);
        //   },
        // ),
      ],
    );
  }
}
