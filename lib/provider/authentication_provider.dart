import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/database_manager/models/myUser.dart';
import 'package:recipe_app/database_manager/myUser_dao.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthenticationProvider extends ChangeNotifier {
  MyUser? dbUser;
  User? firebaseAuthUser;

  String? get userId => dbUser?.id;

  Future<void> updateUser(MyUser user) async {
    // Update the user data
    dbUser = user;
    notifyListeners(); // Notify the listeners to rebuild
  }

  Future<void> register(String email, String password, String userName,
      Uint8List profileImage) async {
    UserCredential credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Upload the profile image to Firebase Storage and get the URL
    String imageUrl = await uploadData(profileImage, credential.user!.uid);

    MyUser user = MyUser(
      id: credential.user!.uid,
      name: userName,
      emailAddress: email,
      profileImageUrl: imageUrl, // Added this line
    );

    await MyUserDao.addUser(user);
  }

  Future<void> login(String email, String password) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      firebaseAuthUser = credential.user;

      if (firebaseAuthUser == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'User not found or session expired.',
        );
      }

      dbUser = await MyUserDao.getUser(firebaseAuthUser!.uid);

      if (dbUser == null) {
        throw Exception('Failed to retrieve user data.');
      }

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateProfileImage(Uint8List profileImage) async {
    if (firebaseAuthUser == null) {
      throw Exception('firebaseAuthUser is null');
    }
    String userId = firebaseAuthUser!.uid;

    // Compress the image before uploading it
    Uint8List compressedImage = await compressImage(profileImage);

    // Upload the compressed image to Firebase Storage and get the URL
    String imageUrl = await uploadData(compressedImage, userId);

    // Update the user profile with the new image URL
    dbUser = await MyUserDao.getUser(userId);
    dbUser?.profileImageUrl = imageUrl;
    await MyUserDao.updateUserProfileImageUrl(dbUser!);

    notifyListeners();
  }

  Future<Uint8List> compressImage(Uint8List image) async {
    // Use a library like image or flutter_image_compress to compress the image
    // For example:
    return await FlutterImageCompress.compressWithList(
      image,
      quality:
          80, // Adjust the quality to balance between file size and image quality
    );
  }

  Future<String> uploadData(Uint8List data, String userId) async {
    Reference reference =
        FirebaseStorage.instance.ref('profile_images/$userId');
    await reference.putData(
        data,
        SettableMetadata(
          contentType: 'image/svg',
          cacheControl: 'public, max-age=31536000', // Cache for 1 year
        ));
    return await reference.getDownloadURL();
  }

  Future<void> updateUserProfile({
    String? name,
    String? email,
    String? password,
    required String currentPassword,
  }) async {
    try {
      // Ensure the user is authenticated
      if (firebaseAuthUser == null) {
        throw Exception('User  is not authenticated.');
      }

      // Log the current user email for debugging
      String userEmail = firebaseAuthUser!.email!;
      print('Current user email: $userEmail');

      // Check if the current password is not empty
      if (currentPassword.isEmpty) {
        throw Exception('Current password cannot be empty.');
      }

      // Re-authenticate the user
      AuthCredential credential = EmailAuthProvider.credential(
        email: userEmail,
        password: currentPassword,
      );

      await firebaseAuthUser!.reauthenticateWithCredential(credential);

      // Update the name directly without re-authentication
      if (name != null) {
        dbUser?.name = name;
        await MyUserDao.updateUser(dbUser!); // Update the user in the database
      }

      // Update email if provided
      if (email != null && email != dbUser?.emailAddress) {
        await firebaseAuthUser!.updateEmail(email);
        dbUser?.emailAddress = email; // Update local user data
      }

      // Update password if provided
      if (password != null && password.isNotEmpty) {
        await firebaseAuthUser!.updatePassword(password);
      }

      notifyListeners(); // Notify listeners of changes
    } on FirebaseAuthException catch (e) {
      print('Update Profile Error: ${e.code} - ${e.message}');
      throw Exception('Failed to update profile: ${e.message}');
    } catch (e) {
      print('An unexpected error occurred: $e');
      throw Exception('Failed to update profile: $e');
    }
  }

  // using shared preferences
  // Future<void> loadUser() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? userId = prefs.getString(kUserLoggedInId);
  //   if (userId != null) {
  //     dbUser = await MyUserDao.getUser(userId);
  //     User? currentUser = FirebaseAuth.instance.currentUser;
  //     if (currentUser != null) {
  //       dbUser = await MyUserDao.getUser(currentUser.uid);
  //       firebaseAuthUser = currentUser;
  //     }
  //     notifyListeners(); // Notify listeners to update the UI
  //   }
  // }

  // using FlutterSecureStorage
// Load user from secure storage

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  Future<void> loadUser() async {
    String? userId = await _secureStorage.read(key: kUserLoggedInId);
    if (userId != null) {
      dbUser = await MyUserDao.getUser(userId);
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        dbUser = await MyUserDao.getUser(currentUser.uid);
        firebaseAuthUser = currentUser;
      }
      notifyListeners(); // Notify listeners to update the UI
    }
  }

  // Save user ID and remember me status
  Future<void> keepUserLoggedIn(String userId, bool keepMeLoggedIn) async {
    await _secureStorage.write(key: kUserLoggedInId, value: userId);
    await _secureStorage.write(
        key: kKeepMeLoggedIn, value: keepMeLoggedIn.toString());
  }

  // To check if the user is remembered
  Future<bool> isUserRemembered() async {
    String? value = await _secureStorage.read(key: kKeepMeLoggedIn);
    return value == 'true';
  }
}
