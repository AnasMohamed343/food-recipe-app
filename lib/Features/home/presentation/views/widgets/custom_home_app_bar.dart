import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Features/profile_screen/presentation/views/widgets/circle_profile_picture.dart';
import 'package:recipe_app/core/styles.dart';
import 'package:recipe_app/core/utiles/routes_manager.dart';
import 'package:recipe_app/core/assets.dart';
import 'package:recipe_app/provider/authentication_provider.dart';

import 'package:provider/provider.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 24.w, left: 24.w, top: 45.h),
      child: Row(
        children: [
          // const Icon(Icons.wb_sunny_outlined, color: kPrimaryColor),
          // const SizedBox(
          //   width: 4,
          // ),
          // const Text(
          //   'Good Morning',
          //   style: Styles.textStyle14,
          // ),
          getTimeBasedIconAndGreeting(DateTime.now()),
          // IconButton(
          //   onPressed: () {
          //     Navigator.pushNamed(context, RoutesManager.cartScreenRoute);
          //   },
          //   icon: SvgPicture.asset(Assets.iconsCartIcon, height: 25, width: 25),
          // ),
        ],
      ),
    );
  }
}

Widget getTimeBasedIconAndGreeting(DateTime currentTime) {
  int hour = currentTime.hour;
  Icon icon;
  String greeting;

  if (hour < 12) {
    icon = const Icon(Icons.wb_sunny_outlined, color: kPrimaryColor);
    greeting = 'Good Morning';
  } else if (hour < 18) {
    icon = const Icon(Icons.wb_sunny_outlined, color: kPrimaryColor);
    greeting = 'Good Afternoon';
  } else {
    icon = const Icon(Icons.nightlight_round, color: kPrimaryColor);
    greeting = 'Good Evening';
  }

  return Row(
    children: [
      icon,
      const SizedBox(
        width: 4,
      ),
      Text(
        greeting,
        style: Styles.textStyle14,
      ),
    ],
  );
}
