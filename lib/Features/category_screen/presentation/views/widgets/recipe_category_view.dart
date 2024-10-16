import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/Features/category_screen/presentation/views/recipes_based_on_category.dart';
import 'package:recipe_app/core/styles.dart';

class RecipeCategoryView extends StatelessWidget {
  final String name, image;
  RecipeCategoryView({
    super.key,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipesBasedOnCategory(
                recipe: name,
              ),
            ));
      },
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: SizedBox(
          height: 150.h,
          width: 150.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100.h,
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(image),
                  ),
                ),
              ),
              const SizedBox(height: 7),
              Center(
                child: Text(
                  name,
                  style: Styles.textStyle14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
