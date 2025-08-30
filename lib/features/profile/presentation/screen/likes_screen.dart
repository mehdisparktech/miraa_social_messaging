import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/item/user_list_item.dart';

class LikesScreen extends StatelessWidget {
  final String postId;
  final int totalLikes;

  const LikesScreen({
    super.key,
    required this.postId,
    required this.totalLikes,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> likedUsers = [
      {
        'userName': 'Ronald Richards',
        'userHandle': '@Courtney',
        'avatarColor': Colors.blue,
      },
      {
        'userName': 'Robert Fox',
        'userHandle': '@Marjorie',
        'avatarColor': Colors.orange,
      },
      {
        'userName': 'Cody Fisher',
        'userHandle': '@Debra',
        'avatarColor': Colors.purple,
      },
      {
        'userName': 'Devon Lane',
        'userHandle': '@Philip',
        'avatarColor': Colors.green,
      },
      {
        'userName': 'Kristin Watson',
        'userHandle': '@Arlene',
        'avatarColor': Colors.red,
      },
      {
        'userName': 'Kathryn Murphy',
        'userHandle': '@Gladys',
        'avatarColor': Colors.teal,
      },
      {
        'userName': 'Savannah Nguyen',
        'userHandle': '@Shawn',
        'avatarColor': Colors.indigo,
      },
    ];

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          _buildLikesHeader(),
          Divider(color: AppColors.borderColor, height: 1),
          SizedBox(height: 10.h),
          Expanded(child: _buildUsersList(likedUsers)),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.textColor, size: 24.sp),
        onPressed: () => Navigator.pop(context),
      ),
      title: CommonText(
        text: 'Likes',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textColor,
      ),
      centerTitle: true,
    );
  }

  Widget _buildLikesHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          Icon(Icons.favorite, color: AppColors.red, size: 20.sp),
          SizedBox(width: 12.w),
          CommonText(
            text: 'People who liked this message',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.white,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget _buildUsersList(List<Map<String, dynamic>> users) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: users.length,
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final user = users[index];
        return Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: UserListItem(
            userName: user['userName'],
            userHandle: user['userHandle'],
            avatarColor: user['avatarColor'],
            onTap: () {
              // Handle user profile navigation
            },
          ),
        );
      },
    );
  }
}
