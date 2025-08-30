import 'package:flutter/material.dart';
import 'package:miraa_social_messaging/component/text/common_text.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CommonText(text: "About")),
      body: Center(child: Text("About")),
    );
  }
}
