import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/core/styles.dart';

class CustomCaloriesWidget extends StatelessWidget {
  String text;
  CustomCaloriesWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.local_fire_department_outlined, color: kNeutralGrey),
        SizedBox(
          width: 4.w,
        ),
        Text(
          text,
          style: Styles.textStyle14.copyWith(color: kNeutralGrey),
        ),
      ],
    );
  }
}
