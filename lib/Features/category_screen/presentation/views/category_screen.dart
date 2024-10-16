import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/Features/category_screen/presentation/views/widgets/category_list.dart';
import 'package:recipe_app/Features/category_screen/presentation/views/widgets/recipe_category_view.dart';
import 'package:recipe_app/Features/component/custom_app_bar.dart';
import 'package:recipe_app/core/styles.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final showBackButton =
        ModalRoute.of(context)?.settings.arguments as bool? ??
            false; // Get the argument
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: 'Categories', back: showBackButton),
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(right: 0, top: 20, left: 20),
                child: SizedBox(
                  height: 30,
                  child: Text(
                    'For You',
                    style: Styles.textStyle20,
                  ),
                ),
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 0,
                childAspectRatio: 0.9,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return RecipeCategoryView(
                      name: name[index], image: image[index]);
                },
                childCount: name.length,
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(right: 0, top: 20, left: 20),
                child: Text(
                  'Categories',
                  style: Styles.textStyle20,
                ),
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 0,
                childAspectRatio: 0.9,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return RecipeCategoryView(
                      name: categories[index], image: categoryImage[index]);
                },
                childCount: categories.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
