import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/core/styles.dart';
import 'package:recipe_app/generated/assets.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24, left: 24, top: 56),
      child: Row(
        children: [
          const Icon(Icons.wb_sunny_outlined, color: kPrimaryColor),
          const SizedBox(
            width: 4,
          ),
          const Text(
            'Good Morning',
            style: Styles.textStyle14,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(Assets.iconsSearchIcon),
          ),
        ],
      ),
    );
  }
}
