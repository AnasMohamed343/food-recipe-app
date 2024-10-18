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
import 'package:recipe_app/Features/component/custom_app_bar.dart';
import 'package:recipe_app/Features/component/custom_text_form_field.dart';
import 'package:recipe_app/Features/profile_screen/presentation/views/profile_screen.dart';
import 'package:recipe_app/core/firebase_error_codes.dart';
import 'package:recipe_app/core/styles.dart';
import 'package:recipe_app/core/utiles/dialog_utils.dart';
import 'package:recipe_app/core/utiles/email_validation.dart';
import 'package:recipe_app/core/utiles/reusable_functions.dart';
import 'package:recipe_app/core/utiles/routes_manager.dart';
import 'package:recipe_app/provider/authentication_provider.dart';
import 'package:provider/provider.dart';

class UpdateProfileDetails extends StatefulWidget {
  const UpdateProfileDetails({super.key});

  @override
  State<UpdateProfileDetails> createState() => _UpdateProfileDetailsState();
}

class _UpdateProfileDetailsState extends State<UpdateProfileDetails> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController currentPasswordController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  Uint8List? _image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    if (authProvider.dbUser == null) {
      authProvider.loadUser().then((_) {
        if (authProvider.dbUser != null &&
            authProvider.firebaseAuthUser == null) {
          authProvider.firebaseAuthUser = FirebaseAuth.instance.currentUser;
        }
      });
    }
    nameController.text = authProvider.dbUser?.name ?? "";
    emailController.text = authProvider.dbUser?.emailAddress ?? "";
    currentPasswordController.text = "";
    newPasswordController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          back: true,
          arrowBackColor: Colors.black,
        ),
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
                    height: 10.h,
                  ),
                  const Text(
                    textAlign: TextAlign.center,
                    "Update Profile",
                    style: Styles.textStyle20,
                  ),
                  const SizedBox(height: 30),
                  Consumer<AuthenticationProvider>(
                      builder: (context, authProvider, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        authProvider.dbUser?.profileImageUrl != null
                            ? CircleAvatar(
                                radius: 60.r,
                                backgroundImage: authProvider
                                            .dbUser?.profileImageUrl !=
                                        null
                                    ? Image.network(
                                        fit: BoxFit.fill,
                                        authProvider.dbUser?.profileImageUrl ??
                                            '',
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            // Image loaded successfully
                                            return child;
                                          } else {
                                            // Image still loading
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                color: kPrimaryColor,
                                              ),
                                            );
                                          }
                                        },
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          // Handle image loading errors
                                          return const Center(
                                            child: Icon(Icons.error),
                                          );
                                        },
                                      ).image
                                    : null,
                              )
                            : const CircleAvatar(
                                radius: 45,
                                backgroundColor: kNeutralGrey,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 70,
                                ),
                              ),
                        Positioned(
                            top: 0.h,
                            right: 130.w,
                            child: CircleAvatar(
                              backgroundColor: Colors.black38,
                              radius: 13.5.r,
                              child: IconButton(
                                  onPressed: () async {
                                    updateProfilePicture();
                                  },
                                  icon: const Icon(
                                    Icons.add_a_photo_rounded,
                                    size: 10,
                                    color: Colors.white,
                                  )),
                            )),
                      ],
                    );
                  }),
                  const SizedBox(height: 20),
                  Text(
                    "Name",
                    style: Styles.textStyle16
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  CustomTextFormField(
                    hintText: "Name",
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    suffixIcon: const Icon(Icons.edit),
                    validator: (input) {
                      if (input != null && input.trim().isNotEmpty) {
                        if (input.length < 6) {
                          return 'Error, name must be at least 6 chars';
                        }
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
                    readOnly: true,
                    suffixIcon: const Icon(Icons.lock),
                    // validator: (input) {
                    //   if (input == null || input.trim().isEmpty) {
                    //     //must make this condition(input == null) first because, the object(input) is nullable
                    //     return 'Plz,,, Enter e-mail address';
                    //   }
                    //   if (!isValidEmail(input)) {
                    //     return 'E-mail bad format';
                    //   }
                    //   return null;
                    // },
                  ),
                  const SizedBox(height: 20.0),
                  Row(children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Current Password",
                            style: Styles.textStyle16
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                          CustomTextFormField(
                            hintText: "current password",
                            controller: currentPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: true,
                            validator: (input) {
                              if (input != null && input.trim().isNotEmpty) {
                                if (input.length < 6) {
                                  return 'Error, password must be at least 6 chars';
                                }
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
                            "New Password",
                            style: Styles.textStyle16
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                          CustomTextFormField(
                            hintText: "new password",
                            controller: newPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: true,
                            validator: (input) {
                              if (input != null && input.trim().isNotEmpty) {
                                if (input == currentPasswordController.text) {
                                  return 'Password cannot be same as current password';
                                }
                                if (input.length < 6) {
                                  return 'Error, password must be at least 6 chars';
                                }
                              }
                              return null;
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
                      updateProfile();
                    },
                    child: Text("Update",
                        style:
                            Styles.textStyle18.copyWith(color: Colors.white)),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateProfile() async {
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

      await authProvider.updateUserProfile(
          email: emailController.text,
          currentPassword: currentPasswordController.text,
          name: nameController.text,
          password: newPasswordController.text);
      if (!mounted) return;
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: "Profile Updated Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        ),
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == FirebaseErrorCodes.weakPassword) {
        DialogUtils.showMessage(context, 'The password provided is too weak.',
            posActionTitle: 'Try Again');
      } else if (e.code == FirebaseErrorCodes.emailInUse) {
        DialogUtils.showMessage(
            context, 'The account already exists for that email.',
            posActionTitle: 'Try Again');
      }
    } catch (e) {
      Navigator.pop(context);
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

  Future<void> updateProfilePicture() async {
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    try {
      DialogUtils.showLoadingDialog(context, 'Updating profile image...');

      Uint8List img = await pickImage(ImageSource.gallery);

      // Update profile image in AuthenticationProvider
      await authProvider.updateProfileImage(img);

      Navigator.pop(context);

      Fluttertoast.showToast(
        msg: "Profile image updated successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      Navigator.pop(context);

      DialogUtils.showMessage(context, e.toString(),
          posActionTitle: 'try again');
    }
  }
}
