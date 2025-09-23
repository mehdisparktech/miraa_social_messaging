import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miraa_social_messaging/features/setting/presentation/controller/about_controller.dart';
import '../../../../component/other_widgets/common_loader.dart';
import '../../../../component/screen/error_screen.dart';
import '../../../../component/text/common_text.dart';
import '../../../../../../utils/enum/enum.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App Bar Section starts here
      appBar: AppBar(
        centerTitle: true,
        title: const CommonText(text: "About", fontSize: 20, fontWeight: FontWeight.w600),
      ),

      /// Body Section starts here
      body: GetBuilder<AboutController>(
        init: AboutController(),
        builder: (controller) => switch (controller.status) {
          /// Loading bar here
          Status.loading => const CommonLoader(),

          /// Error Handle here
          Status.error => ErrorScreen(onTap: AboutController.instance.geAboutRepo()),

          /// Show main data here
          Status.completed => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: CommonText(text: controller.data),
            // Html(data: controller.data.content),
          ),
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:miraa_social_messaging/component/text/common_text.dart';

// class AboutScreen extends StatelessWidget {
//   const AboutScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const CommonText(text: "About")),
//       body: Center(child: Text("About")),
//     );
//   }
// }
