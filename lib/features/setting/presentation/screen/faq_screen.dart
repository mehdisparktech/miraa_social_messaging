import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miraa_social_messaging/component/other_widgets/common_loader.dart';
import 'package:miraa_social_messaging/component/screen/error_screen.dart';
import 'package:miraa_social_messaging/component/text/common_text.dart';
import 'package:miraa_social_messaging/features/setting/presentation/controller/faq_controller.dart';
import 'package:miraa_social_messaging/utils/enum/enum.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CommonText(text: "FAQ")),
      body: GetBuilder<FaqController>(
        init: FaqController(),
        builder: (controller) => switch (controller.status) {
          /// Loading bar here
          Status.loading => const CommonLoader(),

          /// Error Handle here
          Status.error => ErrorScreen(onTap: FaqController.instance.getFaqRepo()),

          /// Show main data here
          Status.completed => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: controller.data.isEmpty
                ? CommonText(text: 'No Data retrived')
                : ListView.builder(
                    itemCount: controller.data.length,
                    itemBuilder: (context, index) {
                      return CommonText(text: controller.data[index]);
                    },
                  ),

            // Html(data: controller.data.content),
          ),
        },
      ),
    );
  }
}
