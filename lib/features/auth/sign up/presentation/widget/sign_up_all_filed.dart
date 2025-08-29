import 'package:flutter/material.dart';
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
        const CommonText(text: "First Name", bottom: 8, top: 12),
        CommonTextField(
          prefixIcon: const Icon(Icons.person),
          hintText: "Enter Your First Name",
          controller: controller.nameController,
          validator: OtherHelper.validator,
        ),
        const CommonText(text: "Last Name", bottom: 8, top: 12),
        CommonTextField(
          prefixIcon: const Icon(Icons.person),
          hintText: "Enter Your Last Name",
          controller: controller.lastNameController,
          validator: OtherHelper.validator,
        ),
        const CommonText(text: "Username", bottom: 8, top: 12),
        CommonTextField(
          prefixIcon: const Icon(Icons.person),
          hintText: "Enter Your Username",
          controller: controller.usernameController,
          validator: OtherHelper.validator,
        ),

        /// User Email here
        const CommonText(text: AppString.email, bottom: 8, top: 12),
        CommonTextField(
          controller: controller.emailController,
          prefixIcon: const Icon(Icons.mail),
          hintText: AppString.email,
          validator: OtherHelper.emailValidator,
        ),

        /// User Password here
        const CommonText(text: AppString.password, bottom: 8, top: 12),
        CommonTextField(
          controller: controller.passwordController,
          prefixIcon: const Icon(Icons.lock),
          isPassword: true,
          hintText: AppString.password,
          validator: OtherHelper.passwordValidator,
        ),
      ],
    );
  }
}
