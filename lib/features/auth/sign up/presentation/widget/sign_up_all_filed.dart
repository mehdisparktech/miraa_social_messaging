import 'package:flutter/material.dart';
import 'package:miraa_social_messaging/component/image/common_image.dart';
import 'package:miraa_social_messaging/utils/constants/app_colors.dart';
import 'package:miraa_social_messaging/utils/constants/app_icons.dart';
import '../../../../../../utils/helpers/other_helper.dart';
import '../../../../../../utils/constants/app_string.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../controller/sign_up_controller.dart';

class SignUpAllField extends StatelessWidget {
  const SignUpAllField({super.key, required this.controller});

  final SignUpController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// User Name here
        const CommonText(text: "First Name", bottom: 8, top: 16),
        CommonTextField(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: CommonImage(imageSrc: AppIcons.person, size: 16),
          ),
          hintText: "Enter Your First Name",
          controller: controller.nameController,
          validator: OtherHelper.validator,
        ),
        const CommonText(text: "Last Name", bottom: 8, top: 16),
        CommonTextField(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: CommonImage(imageSrc: AppIcons.person, size: 16),
          ),
          hintText: "Enter Your Last Name",
          controller: controller.lastNameController,
          validator: OtherHelper.validator,
        ),
        const CommonText(text: "Username", bottom: 8, top: 16),
        CommonTextField(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: CommonImage(imageSrc: AppIcons.person, size: 16),
          ),
          hintText: "Enter Your Username",
          controller: controller.usernameController,
          validator: OtherHelper.validator,
        ),

        /// Category Selection here
        const CommonText(text: "Category", bottom: 8, top: 16),
        CommonTextField(
          isDropdown: true,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: CommonImage(imageSrc: AppIcons.person, size: 16),
            ),
          ),
          hintText: "Select Category",
          dropdownItems: controller.selectedOption.cast<String>(),
          selectedValue: controller.selectRole,
          onDropdownChanged: (String? newValue) {
            if (newValue != null) {
              controller.setSelectedRole(newValue);
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a category';
            }
            return null;
          },
          dropdownColor: AppColors.primaryColor,
        ),

        /// User Email here
        const CommonText(text: AppString.email, bottom: 8, top: 16),
        CommonTextField(
          controller: controller.emailController,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: CommonImage(imageSrc: AppIcons.massage, size: 16),
          ),
          hintText: AppString.email,
          validator: OtherHelper.emailValidator,
        ),

        /// User Password here
        const CommonText(text: AppString.password, bottom: 8, top: 16),
        CommonTextField(
          controller: controller.passwordController,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: CommonImage(imageSrc: AppIcons.password, size: 16),
          ),
          isPassword: true,
          hintText: AppString.password,
          validator: OtherHelper.passwordValidator,
        ),
      ],
    );
  }
}
