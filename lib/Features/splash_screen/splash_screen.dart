import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Features/auth/login/Login.dart';
import 'package:recipe_app/Features/auth/sign_up/Signup.dart';
import 'package:recipe_app/core/assets.dart';
import 'package:recipe_app/core/utiles/routes_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: const Color(0xFF3DA0A7),
        body: Stack(
          children: [
            // Background image
            SvgPicture.asset(
              Assets.startScreen,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              width: double.infinity,
              height: double.infinity,
            ),
            // Positioned(
            //   top: 40,
            //   right: 20,
            //   child: TextButton(
            //     onPressed: () {
            //       // Define your action here
            //       print('Later tapped!');
            //       // Add navigation or any other action
            //       Navigator.pushReplacementNamed(
            //           context, RoutesManager.loginScreenRoute);
            //     },
            //     child: const Text(
            //       'Later',
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 16,
            //         color:
            //             Colors.white, // You can customize the text color here
            //       ),
            //     ),
            //   ),
            // ),

            // Slogan and buttons at the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Help your path to health\n goals with happiness',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Login Button
                    ElevatedButton(
                      onPressed: () {
                        // Action for Login button
                        Navigator.pushReplacementNamed(
                            context, RoutesManager.loginScreenRoute);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 70),
                        backgroundColor: kSecondaryColor, // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Create New Account button
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesManager.signupScreenRoute,
                        );
                      },
                      child: const Text(
                        'Create New Account',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
