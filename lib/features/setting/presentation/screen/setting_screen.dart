import 'package:flutter/material.dart';
import 'package:miraa_social_messaging/component/button/common_button.dart';
import 'package:miraa_social_messaging/utils/constants/app_icons.dart';
import 'package:miraa_social_messaging/utils/constants/app_images.dart';
import '../../../../../../config/route/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/bottom_nav_bar/common_bottom_bar.dart';
import '../../../../component/pop_up/common_pop_menu.dart';
import '../../../../component/text/common_text.dart';
import '../controller/setting_controller.dart';
import '../../../../../../utils/constants/app_colors.dart';
import '../../../../../../utils/constants/app_string.dart';
import '../widgets/setting_item.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App Bar Section starts here
      appBar: AppBar(
        centerTitle: true,
        title: const CommonText(
          text: AppString.settings,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      /// Body Section starts here
      body: GetBuilder<SettingController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                /// Change password Item here
                InkWell(
                  onTap: () => Get.toNamed(AppRoutes.changePassword),
                  child: SettingItem(
                    title: AppString.changePassword,
                    imageSrc: AppIcons.password,
                  ),
                ),
                SizedBox(height: 16.h),

                /// Terms of Service Item here
                InkWell(
                  onTap: () => Get.toNamed(AppRoutes.termsOfServices),
                  child: SettingItem(
                    title: AppString.termsOfServices,
                    imageSrc: AppIcons.faq,
                  ),
                ),
                SizedBox(height: 16.h),

                /// Privacy Policy Item here
                InkWell(
                  onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
                  child: SettingItem(
                    title: AppString.privacyPolicy,
                    imageSrc: AppIcons.privacyPolicy,
                  ),
                ),
                SizedBox(height: 16.h),

                /// About Item here
                InkWell(
                  onTap: () => Get.toNamed(AppRoutes.about),
                  child: SettingItem(
                    title: "About",
                    imageSrc: AppIcons.aboutUs,
                  ),
                ),
                SizedBox(height: 16.h),
                InkWell(
                  onTap: () => Get.toNamed(AppRoutes.faq),
                  child: SettingItem(title: "FAQ", imageSrc: AppIcons.faq),
                ),
                SizedBox(height: 16.h),
                InkWell(
                  onTap: () => Get.toNamed(AppRoutes.helpAndSupport),
                  child: SettingItem(
                    title: "Help & Support",
                    imageSrc: AppIcons.info,
                  ),
                ),
                SizedBox(height: 16.h),

                /// Delete Account Item here
                InkWell(
                  onTap: () => deletePopUp(
                    controller: controller.passwordController,
                    onTap: controller.deleteAccountRepo,
                    isLoading: controller.isLoading,
                  ),
                  child: Container(
                    height: 52.h,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Color(0xFF3F3F3F)),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.delete_outline_rounded,
                          color: AppColors.red,
                        ),
                        CommonText(
                          text: AppString.deleteAccount,
                          color: AppColors.red,
                          left: 12.w,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 100.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CommonButton(
                    isIcon: true,
                    iconImage: AppImages.logOut,
                    titleText: "Log Out",
                    buttonHeight: 50.h,
                    buttonRadius: 10.r,
                    titleSize: 16.sp,
                    titleWeight: FontWeight.w600,
                    titleColor: AppColors.white,
                    buttonColor: AppColors.primaryColor,
                    onTap: () => logOutPopUp(),
                  ),
                ),
              ],
            ),
          );
        },
      ),

      /// Bottom Navigation Bar Section starts here
      bottomNavigationBar: const CommonBottomNavBar(currentIndex: 3),
    );
  }
}
