import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miraa_social_messaging/component/image/common_image.dart';
import '../../utils/constants/app_colors.dart';
import '../text/common_text.dart';

class ActionButton extends StatefulWidget {
  final String iconImage;
  final int count;
  final VoidCallback onTap;
  final bool isActive;
  final Color? activeColor;
  final Color? inactiveColor;
  final double iconSize;
  final double fontSize;
  final VoidCallback? onLikeTap;

  const ActionButton({
    super.key,
    required this.iconImage,
    required this.count,
    required this.onTap,
    this.isActive = false,
    this.activeColor,
    this.inactiveColor,
    this.iconSize = 16,
    this.fontSize = 12,
    this.onLikeTap,
  });

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 150),
          lowerBound: 0.0,
          upperBound: 0.1,
        )..addListener(() {
          setState(() {});
        });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.isActive
        ? (widget.activeColor ?? AppColors.primaryColor)
        : (widget.inactiveColor ?? AppColors.textColor);

    return Transform.scale(
      scale: (1 - _animationController.value).toDouble(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            onTap: widget.onTap,
            child: CommonImage(
              imageSrc: widget.iconImage,
              size: widget.iconSize,
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: widget.onLikeTap ?? () {},
            child: CommonText(
              text: widget.count.toString().padLeft(2, '0'),
              fontSize: widget.fontSize,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }
}
