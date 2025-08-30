import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/item/comment_item.dart';

class CommentsScreen extends StatefulWidget {
  final String postId;
  final int totalComments;

  const CommentsScreen({
    super.key,
    required this.postId,
    required this.totalComments,
  });

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();
  final List<Map<String, dynamic>> _comments = [
    {
      'userName': 'Mark Taylor',
      'comment': 'This made my day! Thank you for the positivity',
      'timeAgo': '19 min ago',
      'likes': 13,
      'avatarColor': Colors.blue,
      'isLiked': false,
    },
    {
      'userName': 'Fatima Henry',
      'comment': 'Yes, Thank you for the positivity!',
      'timeAgo': '22 min ago',
      'likes': 11,
      'avatarColor': Colors.red,
      'isLiked': false,
    },
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildCommentsHeader(),
          Expanded(child: _buildCommentsList()),
          _buildCommentInput(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.black,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.textColor, size: 24.sp),
        onPressed: () => Navigator.pop(context),
      ),
      title: CommonText(
        text: 'Comments',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textColor,
      ),
      centerTitle: true,
    );
  }

  Widget _buildCommentsHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          Icon(Icons.chat_bubble_outline, color: AppColors.body, size: 20.sp),
          SizedBox(width: 12.w),
          CommonText(
            text:
                '${widget.totalComments.toString().padLeft(2, '0')} People Comments on this message',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.body,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsList() {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: _comments.length,
      separatorBuilder: (context, index) => Divider(
        color: AppColors.borderColor2,
        height: 1,
        indent: 20.w,
        endIndent: 20.w,
      ),
      itemBuilder: (context, index) {
        final comment = _comments[index];
        return CommentItem(
          userName: comment['userName'],
          comment: comment['comment'],
          timeAgo: comment['timeAgo'],
          likes: comment['likes'],
          avatarColor: comment['avatarColor'],
          isLiked: comment['isLiked'],
          onLikeTap: () => _toggleCommentLike(index),
        );
      },
    );
  }

  Widget _buildCommentInput() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.black,
        border: Border(
          top: BorderSide(color: AppColors.borderColor2, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: AppColors.borderColor2, width: 1),
              ),
              child: TextField(
                controller: _commentController,
                style: TextStyle(color: AppColors.textColor, fontSize: 14.sp),
                decoration: InputDecoration(
                  hintText: 'Write a positive comment',
                  hintStyle: TextStyle(color: AppColors.body, fontSize: 14.sp),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                ),
                maxLines: null,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: _sendComment,
            child: Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.send, color: AppColors.black, size: 20.sp),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleCommentLike(int index) {
    setState(() {
      _comments[index]['isLiked'] = !_comments[index]['isLiked'];
      if (_comments[index]['isLiked']) {
        _comments[index]['likes']++;
      } else {
        _comments[index]['likes']--;
      }
    });
  }

  void _sendComment() {
    if (_commentController.text.trim().isNotEmpty) {
      setState(() {
        _comments.insert(0, {
          'userName': 'You',
          'comment': _commentController.text.trim(),
          'timeAgo': 'now',
          'likes': 0,
          'avatarColor': AppColors.primaryColor,
          'isLiked': false,
        });
      });
      _commentController.clear();
    }
  }
}
