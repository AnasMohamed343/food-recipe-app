import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/core/assets.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Hits.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/provider/favorite_provider.dart';

class CustomDetailsPicture extends StatelessWidget {
  final Hits hits;
  CustomDetailsPicture({
    super.key,
    required this.hits,
  });

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    return Stack(
      children: [
        Container(
          //width: double.infinity,
          height: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                hits.recipe?.image ?? '',
              ),
            ),
          ),
        ),
        Positioned(
          top: 35.h,
          left: 10.w,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
                size: 30,
              ),
            ),
          ),
        ),
        Positioned(
          top: 35.h,
          right: 10.w,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                favoriteProvider.toggleFavorite(hits);
              },
              // child: Icon(
              //   favoriteProvider.isExist(hits.recipe!)
              //       ? IconlyBold.heart
              //       : IconlyLight.heart,
              //   color: Colors.black,
              //   size: 30,
              // ),
              child: favoriteProvider.isExist(hits)
                  ? SvgPicture.asset(
                      Assets.selectedHeartIcon,
                      height: 30,
                      width: 30,
                    )
                  : SvgPicture.asset(
                      Assets.heartIcon,
                      height: 30,
                      width: 30,
                    ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: MediaQuery.of(context).size.width - 50,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
