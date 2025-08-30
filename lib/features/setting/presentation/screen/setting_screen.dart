import 'package:flutter/material.dart';
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
                  child: const SettingItem(
                    title: AppString.changePassword,
                    iconDate: Icons.lock_outline,
                  ),
                ),
                SizedBox(height: 16.h),

                /// Terms of Service Item here
                InkWell(
                  onTap: () => Get.toNamed(AppRoutes.termsOfServices),
                  child: const SettingItem(
                    title: AppString.termsOfServices,
                    iconDate: Icons.gavel,
                  ),
                ),
                SizedBox(height: 16.h),

                /// Privacy Policy Item here
                InkWell(
                  onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
                  child: const SettingItem(
                    title: AppString.privacyPolicy,
                    iconDate: Icons.network_wifi_1_bar,
                  ),
                ),
                SizedBox(height: 16.h),

                /// About Item here
                InkWell(
                  onTap: () => Get.toNamed(AppRoutes.about),
                  child: const SettingItem(
                    title: "About",
                    iconDate: Icons.info_outline_rounded,
                  ),
                ),
                SizedBox(height: 16.h),
                InkWell(
                  onTap: () => Get.toNamed(AppRoutes.faq),
                  child: const SettingItem(
                    title: "FAQ",
                    iconDate: Icons.help_outline_rounded,
                  ),
                ),
                SizedBox(height: 16.h),
                InkWell(
                  onTap: () => Get.toNamed(AppRoutes.helpAndSupport),
                  child: const SettingItem(
                    title: "Help & Support",
                    iconDate: Icons.help_outline,
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
