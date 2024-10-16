import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Features/details_screen/presentation/views/recipe_details_screen.dart';
import 'package:recipe_app/core/styles.dart';
import 'package:recipe_app/core/utiles/reusable_functions.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Hits.dart';

class CustomItemBasedOnCategory extends StatelessWidget {
  final Hits hits;
  const CustomItemBasedOnCategory({super.key, required this.hits});

  @override
  Widget build(BuildContext context) {
    String formattedTime = ReusableFunctions.formatTotalTime(
        hits.recipe?.totalTime?.toInt().toString() ?? '0');
    return Container(
      padding: EdgeInsets.only(right: 10.w, left: 10.h, bottom: 2.h, top: 10.h),
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                InkWell(
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          hits.recipe?.image ??
                              'https://via.placeholder.com/150',
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 4.h,
                  left: 5.w,
                  child: Container(
                    height: 30.h,
                    width: 56.w,
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        formattedTime,
                        style: Styles.textStyle14
                            .copyWith(color: Colors.white, fontSize: 13.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            flex: 1,
            child: Text(
              textAlign: TextAlign.center,
              hits.recipe?.label ?? 'No Label',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Styles.textStyle16,
            ),
          ),
        ],
      ),
    );
  }
}
