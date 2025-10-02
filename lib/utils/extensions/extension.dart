import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as screenutil;
import 'package:intl/intl.dart';
import 'package:miraa_social_messaging/utils/log/error_log.dart';

extension View on num {
  Widget get height => SizedBox(height: toDouble().h);

  Widget get width => SizedBox(width: toDouble().w);
}

// All Alignments Extensions

extension Alignments on Widget {
  Widget get start => Align(alignment: Alignment.centerLeft, child: this);

  Widget get end => Align(alignment: Alignment.centerRight, child: this);

  Widget get center => Align(alignment: Alignment.center, child: this);
}

// All Alignments Time Formatter Extensions
extension TimeFormater on DateTime {
  String get time => DateFormat('h:mm a').format(this);

  String get date => DateFormat('dd-MM-yyyy').format(this);

  String get dayName => DateFormat('E').format(this);

  String get checkTime {
    DateTime currentDateTime = DateTime.now();
    Duration difference = currentDateTime.difference(this);
    
    if (difference.inDays > 0) {
      if (difference.inDays == 1) {
        return "1 day ago";
      } else if (difference.inDays < 7) {
        return "${difference.inDays} days ago";
      } else if (difference.inDays < 30) {
        int weeks = (difference.inDays / 7).floor();
        return weeks == 1 ? "1 week ago" : "${weeks} weeks ago";
      } else if (difference.inDays < 365) {
        int months = (difference.inDays / 30).floor();
        return months == 1 ? "1 month ago" : "${months} months ago";
      } else {
        int years = (difference.inDays / 365).floor();
        return years == 1 ? "1 year ago" : "${years} years ago";
      }
    } else if (difference.inHours > 0) {
      return difference.inHours == 1 ? "1 hour ago" : "${difference.inHours} hours ago";
    } else if (difference.inMinutes > 0) {
      return difference.inMinutes == 1 ? "1 min ago" : "${difference.inMinutes} mins ago";
    } else {
      return "Just now";
    }
  }
}

extension AsyncTryCatch on Function() {
  tryCatch() async {
    try {
      await this();
    } catch (e, stackTrace) {
      errorLog(stackTrace.toString(), source: "Global Try Catch");
    }
  }
}
