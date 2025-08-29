import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'config/route/app_routes.dart';
import 'config/theme/light_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(428, 926),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: Get.key,
        defaultTransition: Transition.fadeIn,
        theme: themeData.copyWith(
          scaffoldBackgroundColor:
              Colors.transparent, // সব Scaffold transparent
        ),
        transitionDuration: const Duration(milliseconds: 300),
        builder: (context, child) {
          return Container(
            decoration: const BoxDecoration(
              // gradient: LinearGradient(
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              //   transform: GradientRotation(
              //     191.05 * 3.1416 / -120,
              //   ), // degree to radian
              //   colors: [
              //     Color(0xFF000000), // #FFFCE6
              //     Color(0xFFB6E2BC), // #B6E2BC
              //   ],
              //   stops: [0.50, 1.0], // Flutter-friendly range
              // ),
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"), // তোমার image path
                fit: BoxFit.cover,
                //opacity: 1, // Image transparency (optional)
              ),
            ),
            child: child,
          );
        },
        initialRoute: AppRoutes.splash,
        getPages: AppRoutes.routes,
      ),
    );
  }
}
