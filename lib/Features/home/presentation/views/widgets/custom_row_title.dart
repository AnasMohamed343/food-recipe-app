import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/core/styles.dart';

class CustomRowTitle extends StatelessWidget {
  final String title;
  EdgeInsetsGeometry padding;
  CustomRowTitle({required this.title, Key? key, required this.padding})
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
          Text(
            'See All',
            style: Styles.textStyle14.copyWith(color: kPrimaryColor),
          ),
        ],
      ),
    );
  }
}
