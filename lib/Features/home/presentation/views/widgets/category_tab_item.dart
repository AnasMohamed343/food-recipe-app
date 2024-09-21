import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/core/styles.dart';

class CategoryTabItem extends StatelessWidget {
  String title;
  //bool isSelected;
  CategoryTabItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 110.w,
      height: 45.h,
      decoration: BoxDecoration(
        color: Colors.black12.withOpacity(0.07),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        title,
        style: Styles.textStyle16.copyWith(
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
