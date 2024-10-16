import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/core/assets.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 12.r,
      backgroundColor: Colors.white,
      child: Container(
        width: 20.w,
        height: 20.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          image:
              const DecorationImage(image: AssetImage(Assets.profilePicture)),
        ),
      ),
    );
  }
}
