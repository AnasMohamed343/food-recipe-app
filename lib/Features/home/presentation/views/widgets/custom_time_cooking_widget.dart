import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/core/styles.dart';

class CustomTimeCookingWidget extends StatelessWidget {
  String text;
  final Color color;
  CustomTimeCookingWidget(
      {super.key, this.color = Colors.white, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.schedule_outlined, color: color, size: 20.sp),
        SizedBox(
          width: 3.w,
        ),
        Text(
          text,
          style: Styles.textStyle14.copyWith(color: color),
        ),
      ],
    );
  }
}
