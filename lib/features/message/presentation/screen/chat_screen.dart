import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miraa_social_messaging/component/image/common_image.dart';
import 'package:miraa_social_messaging/features/message/presentation/widgets/inbox_feed_item.dart';
import 'package:miraa_social_messaging/utils/constants/app_icons.dart';
import '../../../../component/bottom_nav_bar/common_bottom_bar.dart';
import '../../../../component/other_widgets/common_loader.dart';
import '../../../../component/screen/error_screen.dart';
import '../../../../component/text/common_text.dart';
import '../controller/chat_controller.dart';
import '../../../../../../utils/enum/enum.dart';
import '../../../../../../utils/constants/app_string.dart';
import '../../../../../../utils/constants/app_colors.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App Bar Section Starts here
      appBar: AppBar(
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CommonImage(imageSrc: AppIcons.inbox, size: 24.sp),
        ),
        title: CommonText(
          text: AppString.inbox,
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: AppColors.textColor,
        ),
      ),

      /// Body Section Starts here
      body: GetBuilder<ChatController>(
        builder: (controller) => switch (controller.status) {
          /// Loading bar here
          Status.loading => const CommonLoader(),

          /// Error Handle here
          Status.error => ErrorScreen(
            onTap: ChatController.instance.getChatRepo,
          ),

          /// Show main data here
          Status.completed => Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              children: [
                /// Show all Chat List here
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h),
                    itemCount: 4,
                    padding: EdgeInsets.only(top: 16.h),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        /// Chat List item here
                        child: InboxFeedItem(
                          senderName: "Angel",
                          message: "Hello, how are you?",
                          timeAgo: "10:00 AM",
                          senderAvatarColor: AppColors.primaryColor,
                          isShared: index == 0,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        },
      ),

      /// Bottom Navigation Bar Section Starts here
      bottomNavigationBar: const CommonBottomNavBar(currentIndex: 1),
    );
  }
}
