import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Features/cart_screen/presentation/views/cart_screen.dart';
import 'package:recipe_app/Features/category_screen/presentation/views/category_screen.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/home_view_body.dart';
import 'package:recipe_app/Features/profile_screen/presentation/views/profile_screen.dart';
import 'package:recipe_app/Features/search/presentation/views/search_screen.dart';
import 'package:recipe_app/core/assets.dart';
import 'package:recipe_app/core/utiles/routes_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: tabs[selectedIndex],
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(
          side: BorderSide(width: 0),
        ),
        backgroundColor: kSecondaryColor,
        onPressed: () {
          Navigator.pushNamed(context, RoutesManager.cartScreenRoute);
        },
        child: SvgPicture.asset(
          Assets.iconsCartIcon,
          width: 25,
          height: 25,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Wrap(
          children: [
            BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              // selectedItemColor: kPrimaryColor,
              // unselectedItemColor: kNeutralGrey,
              items: [
                BottomNavigationBarItem(
                  backgroundColor: Colors.transparent,
                  icon: SvgPicture.asset(
                    selectedIndex == 0
                        ? Assets.iconsSelectedHomeIcon
                        : Assets.iconsHomeIcon,
                    width: 28,
                    height: 28,
                    //color: selectedIndex == 0 ? kPrimaryColor : kNeutralGrey,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  backgroundColor: Colors.transparent,
                  icon: SvgPicture.asset(
                    selectedIndex == 1
                        ? Assets.iconsSelectedCategoryIcon
                        : Assets.iconsCategoryIcon,
                    width: 28,
                    height: 28,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  backgroundColor: Colors.transparent,
                  icon: SvgPicture.asset(
                    selectedIndex == 2
                        ? Assets.selectedSearchIcon
                        : Assets.iconsSearchIcon,
                    width: 28,
                    height: 28,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  backgroundColor: Colors.transparent,
                  icon: SvgPicture.asset(
                    selectedIndex == 3
                        ? Assets.iconsSelectedProfileIcon
                        : Assets.iconsProfileIcon,
                    width: 28,
                    height: 28,
                  ),
                  label: '',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> tabs = [
    const HomeViewBody(),
    const CategoryScreen(),
    const SearchScreen(),
    const ProfileScreen()
  ];
}
