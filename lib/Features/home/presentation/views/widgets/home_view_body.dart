import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/category_tab_bar_widget.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/custom_app_bar.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/custom_row_title.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/featured_card_item.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/featured_list_view.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/popular_recipes_list_view.dart';
import 'package:recipe_app/core/styles.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              const Padding(
                padding: EdgeInsets.only(
                  left: 29,
                  top: 0,
                ),
                child: Text(
                  'Alena Sabyan',
                  style: Styles.textStyle24,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 29,
                  top: 0,
                ),
                child: Text(
                  'Featured',
                  style: Styles.textStyle20,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 8,
                  top: 12,
                  //bottom: 24
                ),
                child: FeaturedListView(),
              ),
              CustomRowTitle(
                title: 'Category',
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16, bottom: 18),
                child: CategoryTabBarWidget(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
