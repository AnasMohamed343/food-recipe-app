import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Features/auth/sign_up/Signup.dart';
import 'package:recipe_app/Features/component/custom_text_form_field.dart';
import 'package:recipe_app/core/firebase_error_codes.dart';
import 'package:recipe_app/core/styles.dart';
import 'package:recipe_app/core/utiles/dialog_utils.dart';
import 'package:recipe_app/core/utiles/email_validation.dart';
import 'package:recipe_app/core/utiles/reusable_functions.dart';
import 'package:recipe_app/core/utiles/routes_manager.dart';
import 'package:recipe_app/provider/authentication_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController =
      TextEditingController(); //text: 'anas@gmail.com'

  TextEditingController passwordController =
      TextEditingController(); //text: '123456'
  final formKey = GlobalKey<FormState>();
  bool keepMeLoggedIn = false;
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    final Uint8List? profileImageUrl =
        ModalRoute.of(context)?.settings.arguments as Uint8List?;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            right: 35,
            left: 35,
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 75.h,
                  ),
                  const Text(
                    "Hello,",
                    style: Styles.textStyle24,
                  ),
                  Text(
                    "Welcome Back!",
                    style: Styles.textStyle20
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 10),
                  Consumer<AuthenticationProvider>(
                    builder: (context, authProvider, child) {
                      if (profileImageUrl != null) {
                        // Check if profileImageUrl is not null
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: MemoryImage(profileImageUrl),
                            ),
                            Positioned(
                              top: 0.h,
                              right: 127.w,
                              child: CircleAvatar(
                                radius: 15.r,
                                backgroundColor: Colors.black38,
                                child: IconButton(
                                  onPressed: () async {
                                    Uint8List img =
                                        await pickImage(ImageSource.gallery);
                                    authProvider.updateProfileImage(img);
                                  },
                                  icon: const Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox
                            .shrink(); // Or anyother widget you want to show when profileImageUrl is null
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Email",
                    style: Styles.textStyle16
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    hintText: "Email",
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        //must make this condition(input == null) first because, the object(input) is nullable
                        return 'Plz,,, Enter e-mail address';
                      }
                      if (!isValidEmail(input)) {
                        return 'E-mail bad format';
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Theme(
                        data: ThemeData(
                            unselectedWidgetColor:
                                kNeutralGrey), //checkbox border color
                        child: Checkbox(
                          activeColor: kPrimaryColor,
                          checkColor: Colors.white,
                          value: keepMeLoggedIn,
                          onChanged: (value) {
                            setState(() {
                              keepMeLoggedIn = value!;
                            });
                          },
                        ),
                      ),
                      Text(
                        'Remember me',
                        style: Styles.textStyle16.copyWith(
                            fontWeight: FontWeight.normal,
                            color: kSecondaryColor),
                      ),
                    ],
                  ),
                  Text(
                    "Password",
                    style: Styles.textStyle16
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    isPassword: true,
                    hintText: "Password",
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'Plz,,, Enter password';
                      }
                      if (input.length < 6) {
                        return 'Error, password must be at least 6 chars';
                      }
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Forgot Password action
                      },
                      child: Text(
                        "Forgot Password?",
                        style:
                            Styles.textStyle16.copyWith(color: kPrimaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 64),
                      backgroundColor: kSecondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      login();
                    },
                    child: Text(
                      "Log In",
                      style: Styles.textStyle18.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          // Sign up action
                          Navigator.pushReplacementNamed(
                            context,
                            RoutesManager.signupScreenRoute,
                          );
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(color: kPrimaryColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    if (!(formKey.currentState!.validate())) {
      return;
    }
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        ),
      );

      UserCredential? credential;
      try {
        credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } on FirebaseAuthException catch (e) {
        DialogUtils.hideDialog(context);
        print('FirebaseAuthException: ${e.code} - ${e.message}');
        if (e.code == FirebaseErrorCodes.userNotFound ||
            e.code == FirebaseErrorCodes.wrongPassword) {
          DialogUtils.showMessage(
            context,
            'Wrong email or password',
            posActionTitle: 'Try Again',
          );
        } else {
          DialogUtils.showMessage(
            context,
            'An unexpected error occurred: ${e.message}',
            posActionTitle: 'Try Again',
          );
        }
        return; // Return early if login fails
      }

      if (credential != null) {
        if (keepMeLoggedIn == true) {
          keepUserLoggedIn(credential.user!.uid);
        }
        await authProvider.login(emailController.text, passwordController.text);
        DialogUtils.hideDialog(context);
        Fluttertoast.showToast(
          msg: "Logged In Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pushReplacementNamed(
          context,
          RoutesManager.homeScreenRoute,
        );
      } else {
        DialogUtils.hideDialog(context);
      }
    } catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(
        context,
        e.toString(),
        posActionTitle: 'Try Again',
      );
    }
  }

  void keepUserLoggedIn(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(kKeepMeLoggedIn, keepMeLoggedIn);
    prefs.setString(kUserLoggedInId, userId); // Save the user ID
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }
}
