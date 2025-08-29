import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants/app_colors.dart';
import '../text/common_text.dart';

class CommonAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double radius;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;

  const CommonAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.radius = 20,
    this.backgroundColor = AppColors.yellow,
    this.textColor = AppColors.white,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius.r,
      backgroundColor: backgroundColor,
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
      child: imageUrl == null
          ? CommonText(
              text: _getInitials(),
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: textColor,
            )
          : null,
    );
  }

  String _getInitials() {
    if (name == null || name!.isEmpty) return "U";

    final words = name!.trim().split(' ');
    if (words.length == 1) {
      return words[0][0].toUpperCase();
    } else {
      return (words[0][0] + words[1][0]).toUpperCase();
    }
  }
}
