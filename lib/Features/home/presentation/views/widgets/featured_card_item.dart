import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/Features/details_screen/presentation/views/recipe_details_screen.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/custom_time_cooking_widget.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/profile_picture_widget.dart';
import 'package:recipe_app/core/styles.dart';
import 'package:recipe_app/core/utiles/reusable_functions.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Hits.dart';

class FeaturedCardItem extends StatelessWidget {
  final Hits hits;
  const FeaturedCardItem({super.key, required this.hits});

  @override
  Widget build(BuildContext context) {
    String formattedTime = ReusableFunctions.formatTotalTime(
        hits.recipe?.totalTime?.toInt().toString() ?? '0');
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailsScreen(
              hits: hits,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 1.95 / 0.95,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage('assets/images/featured-Card.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.h,
            right: 0.w,
            child: ClipRRect(
              // Add ClipRRect here
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(140),
                topLeft: Radius.circular(3),
                bottomRight: Radius.circular(3),
              ),
              child: Container(
                height: 150.h,
                width: 155.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.centerRight,
                    image: NetworkImage(
                      hits.recipe?.image ?? '',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 90.h,
            bottom: 37.h,
            left: 16.w,
            // right: 70.w, // this was prevent the text from take the size that i added it to the text with sizeBox
            child: SizedBox(
              width: 220.w,
              child: Text(
                hits.recipe?.label ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.left,
                style: Styles.textStyle18
                    .copyWith(color: Colors.white, fontSize: 17.sp),
              ),
            ),
          ),
          Positioned(
            //top: 88.h,
            bottom: 20.h,
            left: 19.w,
            //right: 130.w,
            child: SizedBox(
              width: 345.w,
              child: Row(
                children: [
                  const ProfilePictureWidget(),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    hits.recipe?.source ?? '',
                    style: Styles.textStyle14.copyWith(color: Colors.white),
                  ),
                  // SizedBox(
                  //   width: 60.w,
                  // ),
                  const Spacer(),
                  CustomTimeCookingWidget(
                    text: formattedTime,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
