import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: AppColors.background,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.transparent,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.textColor),
  ),
);
