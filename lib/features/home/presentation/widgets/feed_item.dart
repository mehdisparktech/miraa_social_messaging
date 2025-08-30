import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miraa_social_messaging/utils/extensions/extension.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/image/common_avatar.dart';
import '../../../../component/button/action_button.dart';
import '../../../../utils/constants/app_colors.dart';
import '../screen/comments_screen.dart';
import '../screen/likes_screen.dart';

class FeedItem extends StatefulWidget {
  final String senderName;
  final String receiverName;
  final String message;
  final String timeAgo;
  final int likes;
  final int comments;
  final int shares;
  final Color senderAvatarColor;
  final Color receiverAvatarColor;
  final String? postId;

  const FeedItem({
    super.key,
    required this.senderName,
    required this.receiverName,
    required this.message,
    required this.timeAgo,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.senderAvatarColor,
    required this.receiverAvatarColor,
    this.postId,
  });

  @override
  State<FeedItem> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  late int _likes;
  late int _comments;
  late int _shares;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _likes = widget.likes;
    _comments = widget.comments;
    _shares = widget.shares;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //height: 182.h,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Color(0xFF000804),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(17.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header with two users and arrow
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Sender (Angel)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonAvatar(
                      name: widget.senderName,
                      radius: 16,
                      backgroundColor: widget.senderAvatarColor,
                      textColor: AppColors.white,
                      fontSize: 12,
                    ),
                    SizedBox(width: 12.w),
                    CommonText(
                      text: widget.senderName,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                16.width,

                // Arrow
                Icon(
                  Icons.arrow_forward,
                  color: AppColors.primaryColor,
                  size: 24.sp,
                ),
                16.width,

                // Receiver (Shawn)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonAvatar(
                      name: widget.receiverName,
                      radius: 16,
                      backgroundColor: widget.receiverAvatarColor,
                      textColor: AppColors.white,
                      fontSize: 12,
                    ),
                    SizedBox(width: 12.w),
                    CommonText(
                      text: widget.receiverName,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Message container with green border
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                // Left border only
                border: Border(
                  left: BorderSide(
                    width: 4.w,
                    color: Color(0xFF027348), // Primary color
                  ),
                ),
              ),
              child: CommonText(
                text: widget.message,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.body,
                maxLines: 3,
                textAlign: TextAlign.left,
              ),
            ),

            SizedBox(height: 16.h),

            // Actions and time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onLongPress: () {
                        Get.to(
                          () => LikesScreen(
                            postId: widget.postId ?? 'default',
                            totalLikes: _likes,
                          ),
                        );
                      },
                      child: ActionButton(
                        icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                        count: _likes,
                        onTap: _toggleLike,
                        isActive: _isLiked,
                        activeColor: AppColors.red,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    ActionButton(
                      icon: Icons.chat_bubble_outline,
                      count: _comments,
                      onTap: _navigateToComments,
                    ),
                    SizedBox(width: 16.w),
                    ActionButton(
                      icon: Icons.share_outlined,
                      count: _shares,
                      onTap: _sharePost,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: _navigateToLikes,
                  child: CommonText(
                    text: widget.timeAgo,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: AppColors.body,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      if (_isLiked) {
        _likes++;
      } else {
        _likes--;
      }
    });
  }

  void _navigateToComments() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentsScreen(
          postId: widget.postId ?? 'default',
          totalComments: _comments,
        ),
      ),
    );
  }

  void _navigateToLikes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            LikesScreen(postId: widget.postId ?? 'default', totalLikes: _likes),
      ),
    );
  }

  void _sharePost() {
    setState(() {
      _shares++;
    });
    // Add share functionality here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Post shared!'),
        backgroundColor: AppColors.primaryColor,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
