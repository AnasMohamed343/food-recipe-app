import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/custom_time_cooking_widget.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/profile_picture_widget.dart';
import 'package:recipe_app/core/styles.dart';
import 'package:recipe_app/generated/assets.dart';

class FeaturedCardItem extends StatelessWidget {
  const FeaturedCardItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.58 / 1,
          child: SvgPicture.asset(
            width: 270.w,
            height: 180.h,
            Assets.imagesFeaturedCard,
            fit: BoxFit.fill, // or BoxFit.fill
          ),
        ),
        Positioned(
          top: 88.h,
          bottom: 46.h,
          left: 16.w,
          right: 59.w,
          child: Text(
            'Asian white noodle\nwith extra seafood',
            style: Styles.textStyle18.copyWith(color: Colors.white),
          ),
        ),
        Positioned(
          //top: 88.h,
          bottom: 10.h,
          left: 16.w,
          //right: 130.w,
          child: Row(
            children: [
              const ProfilePictureWidget(),
              SizedBox(
                width: 8.w,
              ),
              Text(
                'James Spader',
                style: Styles.textStyle14.copyWith(color: Colors.white),
              ),
              SizedBox(
                width: 50.w,
              ),
              CustomTimeCookingWidget(
                text: '30 min',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
