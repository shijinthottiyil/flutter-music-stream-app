import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_stream/utils/constants/app_colors.dart';

class PlayErrorWidget extends StatelessWidget {
  const PlayErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      height: 70.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.kGreen,
      ),
      child: Icon(
        Icons.error_rounded,
        size: 56.h,
      ),
    );
  }
}
