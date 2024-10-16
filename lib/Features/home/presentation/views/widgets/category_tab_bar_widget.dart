import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Features/category_screen/presentation/views/recipes_based_on_category.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/category_tab_item.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/custom_row_title.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/popular_recipes_list_view.dart';

class CategoryTabBarWidget extends StatelessWidget {
  const CategoryTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              height: 45.h,
              child: TabBar(
                  padding: EdgeInsets.zero,
                  indicator: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  //isScrollable: true,
                  indicatorColor: kPrimaryColor,
                  dividerColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  labelPadding: EdgeInsets.symmetric(horizontal: 3.w),
                  tabs: [
                    CategoryTabItem(title: 'breakfast'),
                    CategoryTabItem(title: 'lunch'),
                    CategoryTabItem(title: 'dinner'),
                    CategoryTabItem(title: 'quick'),
                  ]),
            ),
            SizedBox(
              height: 15.h,
            ),
            CustomRowTitle(
              title: 'Popular Recipes',
              padding: EdgeInsets.only(right: 24.w, left: 10.w),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RecipesBasedOnCategory(
                              recipe: 'Popular',
                            )));
              },
            ),
            SizedBox(
              height: 15.h,
            ),
            SizedBox(
              height: 240.h,
              child: const TabBarView(children: [
                PopularRecipesListView(
                  recipe: 'breakfast',
                ),
                PopularRecipesListView(
                  recipe: 'lunch',
                ),
                PopularRecipesListView(
                  recipe: 'dinner',
                ),
                PopularRecipesListView(
                  recipe: 'quick',
                ),
              ]),
            ),
          ],
        ));

    // return SizedBox(
    //   height: 45.h,
    //   child: ListView.builder(
    //     padding: EdgeInsets.zero,
    //     scrollDirection: Axis.horizontal,
    //     itemBuilder: (context, index) {
    //       return const Padding(
    //         padding: EdgeInsets.symmetric(horizontal: 8),
    //         child: CategoryTabItem(),
    //       );
    //     },
    //   ),
    // );
  }
}
