import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Features/details_screen/presentation/views/recipe_details_screen.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/custom_calories_widget.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/custom_time_cooking_widget.dart';
import 'package:recipe_app/core/assets.dart';
import 'package:recipe_app/core/styles.dart';
import 'package:recipe_app/core/utiles/reusable_functions.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Hits.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Recipe.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/provider/favorite_provider.dart';

class PopularRecipesCard extends StatelessWidget {
  final Hits hits;
  final Recipe? recipe;
  PopularRecipesCard({
    super.key,
    required this.hits,
    this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    String formattedTime = ReusableFunctions.formatTotalTime(
        hits.recipe?.totalTime?.toInt().toString() ?? '0');
    //String? imageUrl = hits.recipe?.image;
    return AspectRatio(
      aspectRatio: 5 / 6,
      child: Container(
        alignment: Alignment.center,
        //color: Colors.white,
        width: 200.w,
        height: 240.h,
        decoration: BoxDecoration(
          color: Colors.white, // Background color of the container
          border: Border.all(
            color: Colors.grey.withOpacity(0.09), // Border color
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.circular(16), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black26.withOpacity(0.07), // Shadow color
              blurRadius: 12, // Shadow blur radius
              offset: const Offset(0, 2), // Shadow offset
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
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
                      height: 128.w,
                      width: 168.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            hits.recipe?.image ??
                                'https://via.placeholder.com/150',
                          ),
                        ),
                      ),
                      //child: _buildImage(imageUrl), // Use _buildImage here
                    ),
                  ),
                  Positioned(
                    top: 3,
                    right: 3,
                    child: InkWell(
                      onTap: () {
                        favoriteProvider.toggleFavorite(hits);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 14.6.r,
                        child: favoriteProvider.isExist(hits)
                            ? SvgPicture.asset(
                                Assets.selectedHeartIcon,
                                height: 22,
                                width: 22,
                              )
                            : SvgPicture.asset(
                                Assets.heartIcon,
                                height: 22,
                                width: 22,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6.h,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 6),
                child: SizedBox(
                  height: 46.h,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9),
                    child: Text(
                      textAlign: TextAlign.center,
                      hits.recipe?.label ?? '',
                      style: Styles.textStyle16,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CustomCaloriesWidget(
                  //   text: '${hits.recipe?.calories?.toInt()} Cal',
                  // ),
                  CustomCaloriesWidget(
                    text:
                        '${(hits.recipe?.calories ?? 0).toInt() > 999 ? (hits.recipe?.calories ?? 0).toInt().toString().substring(0, 3) : (hits.recipe?.calories ?? 0).toInt().toString()} Cal',
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: SvgPicture.asset(
                      width: 4.w,
                      height: 4.h,
                      'assets/images/Separator.svg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  CustomTimeCookingWidget(
                    color: kNeutralGrey,
                    text: formattedTime,
                    // text: '${hits.recipe?.totalTime?.toInt().toString()} Min'
                    //'${(hits.recipe?.totalTime ?? 0).toInt() > 99 ? (hits.recipe?.totalTime ?? 0).toInt().toString().substring(0, 2) : (hits.recipe?.totalTime ?? 0).toInt().toString()} Min',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
