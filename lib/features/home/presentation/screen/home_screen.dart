import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miraa_social_messaging/component/bottom_nav_bar/common_bottom_bar.dart';
import '../controller/home_controller.dart';
import '../widgets/home_header.dart';
import '../widgets/message_input_section.dart';
import '../widgets/streak_section.dart';
import '../widgets/positivity_feeds_section.dart';
import '../../../../utils/constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const HomeHeader(),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: AppColors.transparent),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          const MessageInputSection(),
                          SizedBox(height: 24.h),
                          const StreakSection(),
                          SizedBox(height: 24.h),
                          const PositivityFeedsSection(),
                          SizedBox(height: 100.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const CommonBottomNavBar(currentIndex: 0),
        );
      },
    );
  }
}
