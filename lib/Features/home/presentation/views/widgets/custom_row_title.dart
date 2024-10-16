import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/core/styles.dart';

class CustomRowTitle extends StatelessWidget {
  final String title;
  EdgeInsetsGeometry padding;
  void Function()? onTap;
  CustomRowTitle(
      {required this.title, Key? key, this.onTap, required this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Text(
            title,
            style: Styles.textStyle20,
          ),
          const Spacer(),
          GestureDetector(
            onTap: onTap,
            child: Text(
              'See All',
              style: Styles.textStyle14.copyWith(color: kPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
