import 'package:flutter/material.dart';
import 'package:miraa_social_messaging/component/text/common_text.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CommonText(text: "FAQ")),
      body: Center(child: Text("FAQ")),
    );
  }
}
