import 'package:flutter/material.dart';
import 'package:miraa_social_messaging/component/bottom_nav_bar/common_bottom_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(children: [Text("Home")]),
      bottomNavigationBar: CommonBottomNavBar(currentIndex: 0),
    );
  }
}
