import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/category_tab_bar_widget.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/custom_row_title.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/featured_card_item.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/featured_recipes_view.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/popular_recipes_list_view.dart';
import 'package:recipe_app/Features/profile_screen/presentation/views/widgets/circle_profile_picture.dart';
import 'package:recipe_app/core/styles.dart';
import 'package:recipe_app/core/utiles/routes_manager.dart';
import 'package:recipe_app/database_manager/models/myUser.dart';
import 'package:recipe_app/database_manager/myUser_dao.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/provider/authentication_provider.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthenticationProvider>(context);
    // Load user data if not already loaded
    if (authProvider.dbUser == null) {
      authProvider.loadUser();
    }
    final String userName = authProvider.dbUser?.name ?? '';
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomHomeAppBar(),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 20,
                  // top: 2,
                ),
                child: Row(
                  children: [
                    Text(
                      userName,
                      style: Styles.textStyle24,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RoutesManager.profileScreenRoute);
                      },
                      child: CircleProfilePicture(
                          width: MediaQuery.of(context).size.width / 7,
                          height: MediaQuery.of(context).size.width / 7,
                          imageUrl: authProvider.dbUser?.profileImageUrl ??
                              'https://i.pravatar.cc/300'),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 25,
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
                child: FeaturedRecipesView(
                  recipe: 'featured',
                ),
              ),
              CustomRowTitle(
                title: 'Category',
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                onTap: () {
                  Navigator.pushNamed(
                    context, RoutesManager.categoryScreenRoute,
                    arguments: true, // Pass true to show back button
                  );
                },
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
