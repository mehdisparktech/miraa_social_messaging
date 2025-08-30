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
        'senderName': 'Angel',
        'receiverName': 'Shawn',
        'message':
            'Remember, every small step forward is still progress. You\'re doing better than you think! ✨',
        'timeAgo': '2 min ago',
        'likes': 19,
        'comments': 12,
        'shares': 4,
        'senderAvatarColor': Colors.purple,
        'receiverAvatarColor': AppColors.yellow,
      },
      {
        'senderName': 'Max',
        'receiverName': 'Arthur',
        'message':
            'Remember, every small step forward is still progress. You\'re doing better than you think! ✨',
        'timeAgo': '5 min ago',
        'likes': 8,
        'comments': 6,
        'shares': 2,
        'senderAvatarColor': AppColors.red,
        'receiverAvatarColor': Colors.blue,
      },
      {
        'senderName': 'Mitchell',
        'receiverName': 'Eduardo',
        'message':
            'Remember, every small step forward is still progress. You\'re doing better than you think! ✨',
        'timeAgo': '8 min ago',
        'likes': 22,
        'comments': 18,
        'shares': 6,
        'senderAvatarColor': Colors.purple,
        'receiverAvatarColor': Colors.green,
      },
      {
        'senderName': 'Marjorie',
        'receiverName': 'Kyle',
        'message':
            'Remember, every small step forward is still progress. You\'re doing better than you think! ✨',
        'timeAgo': '12 min ago',
        'likes': 15,
        'comments': 9,
        'shares': 3,
        'senderAvatarColor': Colors.blue,
        'receiverAvatarColor': Colors.orange,
      },
      {
        'senderName': 'Colleen',
        'receiverName': 'Shane',
        'message':
            'Remember, every small step forward is still progress. You\'re doing better than you think! ✨',
        'timeAgo': '15 min ago',
        'likes': 31,
        'comments': 25,
        'shares': 8,
        'senderAvatarColor': Colors.green,
        'receiverAvatarColor': Colors.red,
      },
      {
        'senderName': 'Esther',
        'receiverName': 'Courtney',
        'message':
            'Remember, every small step forward is still progress. You\'re doing better than you think! ✨',
        'timeAgo': '18 min ago',
        'likes': 19,
        'comments': 14,
        'shares': 5,
        'senderAvatarColor': Colors.orange,
        'receiverAvatarColor': Colors.purple,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: "Positivity Feeds",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textColor,
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: AppColors.transparent,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColors.borderColor2),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: feedData.length,
            separatorBuilder: (context, index) =>
                Divider(color: AppColors.borderColor2, height: 1),
            itemBuilder: (context, index) {
              final feed = feedData[index];
              return FeedItem(
                senderName: feed['senderName'],
                receiverName: feed['receiverName'],
                message: feed['message'],
                timeAgo: feed['timeAgo'],
                likes: feed['likes'],
                comments: feed['comments'],
                shares: feed['shares'],
                senderAvatarColor: feed['senderAvatarColor'],
                receiverAvatarColor: feed['receiverAvatarColor'],
                postId: 'post_$index',
              );
            },
          ),
        ),
      ],
    );
  }
}
