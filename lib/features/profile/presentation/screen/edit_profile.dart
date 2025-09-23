import 'dart:io';
import 'package:flutter/material.dart';
import 'package:miraa_social_messaging/component/other_widgets/common_loader.dart';
import 'package:miraa_social_messaging/component/screen/error_screen.dart';
import 'package:miraa_social_messaging/features/setting/presentation/controller/faq_controller.dart';
import 'package:miraa_social_messaging/utils/constants/app_colors.dart';
import 'package:miraa_social_messaging/utils/constants/app_icons.dart';
import 'package:miraa_social_messaging/utils/enum/enum.dart';
import '../../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/button/common_button.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../controller/profile_controller.dart';
import '../../../../../../utils/constants/app_images.dart';
import '../../../../../../utils/constants/app_string.dart';
import '../widgets/edit_profile_all_filed.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App Bar Sections Starts here
      appBar: AppBar(
        centerTitle: true,
        title: const CommonText(
          text: AppString.editProfile,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      /// Body Sections Starts here
      body: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) => switch (controller.status) {
          /// Loading bar here
          Status.loading => const CommonLoader(),

          /// Error Handle here
          Status.error => ErrorScreen(onTap: ProfileController.instance.getProfileRepo),

          /// Show main data here
          Status.completed => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: MainEditProfileBody(controller: controller),

            // Html(data: controller.data.content),
          ),
        },
      ),
    );
  }
}

class MainEditProfileBody extends StatelessWidget {
  final ProfileController controller;
  const MainEditProfileBody({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          /// User Profile image here
          Stack(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60.sp,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: controller.image != null
                        ? Image.file(
                            File(controller.image!),
                            width: 120,
                            height: 120,
                            fit: BoxFit.fill,
                          )
                        : const CommonImage(
                            imageSrc: AppImages.onboarding1,
                            height: 120,
                            width: 120,
                            fill: BoxFit.cover,
                          ),
                  ),
                ),
              ),

              /// image change icon here
              Positioned(
                bottom: 0,
                left: Get.width * 0.53,
                child: IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateColor.resolveWith(
                      (states) => AppColors.yellow,
                    ),
                  ),
                  onPressed: controller.getProfileImage,
                  icon: CommonImage(imageSrc: AppIcons.camera, size: 20.sp),
                ),
              ),
            ],
          ),

          /// user all information filed here
          EditProfileAllFiled(controller: controller),
          30.height,

          /// Submit Button here
          CommonButton(
            titleText: AppString.saveAndChanges,
            isLoading: controller.isLoading,
            onTap: controller.editProfileRepo,
          ),
        ],
      ),
    );
  }
}
