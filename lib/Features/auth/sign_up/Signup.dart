import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Features/auth/login/Login.dart';
import 'package:recipe_app/Features/component/custom_text_form_field.dart';
import 'package:recipe_app/core/firebase_error_codes.dart';
import 'package:recipe_app/core/styles.dart';
import 'package:recipe_app/core/utiles/dialog_utils.dart';
import 'package:recipe_app/core/utiles/email_validation.dart';
import 'package:recipe_app/core/utiles/reusable_functions.dart';
import 'package:recipe_app/core/utiles/routes_manager.dart';
import 'package:recipe_app/provider/authentication_provider.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(right: 30, left: 30),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 45.h,
                  ),
                  const Text(
                    "Create an account",
                    style: Styles.textStyle20,
                  ),
                  Text(
                    "Let's help you to set up your account,\nit won't take long.",
                    style: Styles.textStyle14.copyWith(color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 50.r,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : const CircleAvatar(
                              radius: 50,
                              backgroundColor: kNeutralGrey,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 70,
                              ),
                            ),
                      Positioned(
                        top:
                            0.h, // Make sure this value doesn't push it too far
                        right: 130.w, // Adjust the positioning appropriately
                        child: CircleAvatar(
                          radius: 14.r,
                          backgroundColor: Colors.black38,
                          child: IconButton(
                            onPressed: () async {
                              await selectImage();
                            },
                            icon: Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                              size: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Name",
                    style: Styles.textStyle16
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  CustomTextFormField(
                    hintText: "Name",
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'Plz,,, Enter Name';
                      }
                      if (input.length < 6) {
                        return 'Error, name must be at least 6 chars';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Email",
                    style: Styles.textStyle16
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
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
                  const SizedBox(height: 20.0),
                  Row(children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Password",
                            style: Styles.textStyle16
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                          CustomTextFormField(
                            hintText: "Password",
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: true,
                            validator: (input) {
                              if (input == null || input.trim().isEmpty) {
                                return 'Plz,,, Enter Password';
                              }
                              if (input.length < 6) {
                                return 'Error, password must be at least 6 chars';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Confirm Password",
                            style: Styles.textStyle16
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                          CustomTextFormField(
                            hintText: "Confirm Password",
                            controller: confirmPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: true,
                            validator: (input) {
                              if (input == null || input.trim().isEmpty) {
                                //must make this condition(input == null) first because, the object(input) is nullable
                                return 'Plz,,, Enter password';
                              }
                              if (input != passwordController.text) {
                                return 'Password not match';
                              }
                              return null; // by default returns null
                            },
                          ),
                        ],
                      ),
                    ),
                  ]),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 64),
                      backgroundColor:
                          kSecondaryColor, //const Color(0xFF3DA0A7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      signUp();
                    },
                    child: Text("Sign up",
                        style:
                            Styles.textStyle18.copyWith(color: Colors.white)),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already a member?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            RoutesManager.loginScreenRoute,
                          );
                        },
                        child: const Text(
                          "Sign in",
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

  void signUp() async {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    if (!(formKey.currentState!.validate())) {
      return;
    }
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        //useRootNavigator: true,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        ),
      );
      if (_image == null) {
        Navigator.pop(context); // Close the dialog
        Fluttertoast.showToast(
          msg: "Please select an image",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return;
      }
      await authProvider.register(emailController.text, passwordController.text,
          nameController.text, _image!);
      if (!mounted) return;
      Navigator.pop(context); // Close the dialog
      Fluttertoast.showToast(
        msg: "User Registered Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pushReplacementNamed(context, RoutesManager.loginScreenRoute,
          arguments: _image);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Close the dialog
      if (e.code == FirebaseErrorCodes.weakPassword) {
        DialogUtils.showMessage(context, 'The password provided is too weak.',
            posActionTitle: 'Try Again');
      } else if (e.code == FirebaseErrorCodes.emailInUse) {
        DialogUtils.showMessage(
            context, 'The account already exists for that email.',
            posActionTitle: 'Try Again');
      }
    } catch (e) {
      Navigator.pop(context); // Close the dialog
      DialogUtils.showMessage(context, e.toString(),
          posActionTitle: 'Try Again');
    }
  }

  Future<void> selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }
}
