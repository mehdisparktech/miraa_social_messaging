import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import 'feed_item.dart';

class PositivityFeedsSection extends StatelessWidget {
  const PositivityFeedsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> feedData = [
      {
        'name': 'Angel',
        'username': 'Chosen',
        'message':
            'remember every small step forward is still progress. you\'re doing better than you think! ✨',
        'timeAgo': '2 mins ago',
        'likes': 14,
        'comments': 12,
        'shares': 4,
        'avatarColor': AppColors.yellow,
      },
      {
        'name': 'Max',
        'username': 'Arthur',
        'message':
            'remember every small step forward is still progress. you\'re doing better than you think! ✨',
        'timeAgo': '5 mins ago',
        'likes': 8,
        'comments': 6,
        'shares': 2,
        'avatarColor': AppColors.red,
      },
      {
        'name': 'Mitchell',
        'username': 'Eduardo',
        'message':
            'remember every small step forward is still progress. you\'re doing better than you think! ✨',
        'timeAgo': '8 mins ago',
        'likes': 22,
        'comments': 18,
        'shares': 6,
        'avatarColor': Colors.purple,
      },
      {
        'name': 'Marjorie',
        'username': 'Kyle',
        'message':
            'remember every small step forward is still progress. you\'re doing better than you think! ✨',
        'timeAgo': '12 mins ago',
        'likes': 15,
        'comments': 9,
        'shares': 3,
        'avatarColor': Colors.blue,
      },
      {
        'name': 'Colleen',
        'username': 'Shane',
        'message':
            'remember every small step forward is still progress. you\'re doing better than you think! ✨',
        'timeAgo': '15 mins ago',
        'likes': 31,
        'comments': 25,
        'shares': 8,
        'avatarColor': Colors.green,
      },
      {
        'name': 'Esther',
        'username': 'Courtney',
        'message':
            'remember every small step forward is still progress. you\'re doing better than you think! ✨',
        'timeAgo': '18 mins ago',
        'likes': 19,
        'comments': 14,
        'shares': 5,
        'avatarColor': Colors.orange,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: "Positivity Feeds",
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textColor,
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 16.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: feedData.length,
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemBuilder: (context, index) {
            final feed = feedData[index];
            return FeedItem(
              name: feed['name'],
              username: feed['username'],
              message: feed['message'],
              timeAgo: feed['timeAgo'],
              likes: feed['likes'],
              comments: feed['comments'],
              shares: feed['shares'],
              avatarColor: feed['avatarColor'],
            );
          },
        ),
      ],
    );
  }
}
