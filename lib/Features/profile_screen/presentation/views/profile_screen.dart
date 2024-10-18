import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Features/component/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/popular_recipes_card.dart';
import 'package:recipe_app/Features/profile_screen/presentation/views/widgets/circle_profile_picture.dart';
import 'package:recipe_app/Features/profile_screen/presentation/views/widgets/favorite_screen.dart';
import 'package:recipe_app/Features/profile_screen/presentation/views/widgets/favorites_gridview.dart';
import 'package:recipe_app/Features/profile_screen/presentation/views/widgets/update_profile_details.dart';
import 'package:recipe_app/core/assets.dart';
import 'package:recipe_app/core/styles.dart';
import 'package:recipe_app/core/utiles/reusable_functions.dart';
import 'package:recipe_app/core/utiles/routes_manager.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Hits.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Recipe.dart';
import 'package:recipe_app/provider/authentication_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          back: false,
          elevation: 0.0,
          backgroundColor: kPrimaryColorMoreDark,
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    child: Container(
                      width: screenWidth,
                      height: screenHeight / 2.5,
                    ),
                    painter: HeaderCurvedContainer(),
                  ),
                  Positioned(
                    top: 23.h,
                    child: Consumer<AuthenticationProvider>(
                        builder: (context, authProvider, child) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Profile',
                            style: Styles.textStyle24
                                .copyWith(color: Colors.white, fontSize: 28),
                          ),
                          const SizedBox(height: 22),
                          CircleProfilePicture(
                              width: screenWidth / 2.5,
                              height: screenWidth / 2.5,
                              imageUrl:
                                  authProvider.dbUser?.profileImageUrl ?? ''),
                          const SizedBox(height: 3),
                          Text(
                            authProvider.dbUser?.name ?? '',
                            style: Styles.textStyle24,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            authProvider.dbUser?.emailAddress ?? '',
                            style: Styles.textStyle20
                                .copyWith(color: Colors.black54),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.red.withOpacity(0.4),
                          radius: 24,
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 33,
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          'Favorites',
                          style: Styles.textStyle18,
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const FavoriteScreen(),
                                  ));
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 21,
                            )),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.green.withAlpha(250),
                          radius: 24,
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          'Update Profile',
                          style: Styles.textStyle18,
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UpdateProfileDetails()),
                              ).then((value) {
                                // When the user comes back from the update profile screen
                                _reloadProfileData(); // Reload the profile data
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 21,
                            )),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: kNeutralGrey.withAlpha(250),
                          radius: 24,
                          child: IconButton(
                            onPressed: () async {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              pref.clear();
                              await signOut(context);
                            },
                            icon: const Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          'Logout',
                          style: Styles.textStyle18,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signOut(context) async {
    await FirebaseAuth.instance.signOut();
    // delete the Flutter Secure Storage stored token for this user
    final storage = FlutterSecureStorage();
    await storage.delete(key: kUserLoggedInId);
    await storage.delete(key: kKeepMeLoggedIn);
    Navigator.pushReplacementNamed(context, RoutesManager.splashScreenRoute);
  }

  void _reloadProfileData() {
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    authProvider.loadUser();
    //setState(() {});//if i want the data of the user to be reloaded more speedy, but loadUser has notifyListeners in the provider, so it do the jop but the data will be reloaded slow than the setState.
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = kPrimaryColorMoreDark;
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
