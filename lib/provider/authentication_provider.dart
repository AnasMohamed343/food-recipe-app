import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    String imageUrl =
        await uploadProfileImage(profileImage, credential.user!.uid);

    MyUser user = MyUser(
      id: credential.user!.uid,
      name: userName,
      emailAddress: email,
      profileImageUrl: imageUrl, // Added this line
    );

    await MyUserDao.addUser(user);
  }

  Future<void> login(String email, String password) async {
    var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    firebaseAuthUser = credential.user;

    // Fetch the user data from Firestore
    dbUser = await MyUserDao.getUser(firebaseAuthUser!.uid);

    notifyListeners();
  }

  Future<void> updateProfileImage(Uint8List profileImage) async {
    if (firebaseAuthUser == null) {
      // Handle the case where firebaseAuthUser is null
      //You can either return early or throw an exception
      throw Exception('firebaseAuthUser is null');
      return; // Or throw an exception
    }
    String userId = firebaseAuthUser!.uid;

    // Upload the profile image to Firebase Storage and get the URL
    String imageUrl = await uploadProfileImage(profileImage, userId);

    // Update the user profile with the new image URL
    dbUser = await MyUserDao.getUser(userId);
    dbUser?.profileImageUrl = imageUrl;
    await MyUserDao.updateUser(dbUser!);

    notifyListeners();
  }

  Future<String> uploadProfileImage(Uint8List image, String userId) async {
    var storageRef =
        FirebaseStorage.instance.ref().child('profileImages').child(userId);
    await storageRef.putData(image);
    return await storageRef.getDownloadURL();
  }

  Future<void> updateUserProfile({
    String? name,
    String? email,
    String? password,
    required String currentPassword, // Add currentPassword parameter
  }) async {
    // Update user details in Firestore
    dbUser?.name = name;
    dbUser?.emailAddress = email;
    await MyUserDao.updateUser(dbUser!);

    // Re-authenticate the user
    try {
      // Create a credential with the current password
      AuthCredential credential = EmailAuthProvider.credential(
        email: firebaseAuthUser?.email ?? '',
        password: currentPassword,
      );

      // Re-authenticate the user
      await firebaseAuthUser?.reauthenticateWithCredential(
          credential); // Update email and password in Firebase Authentication
      if (email != null && email != dbUser?.emailAddress) {
        await firebaseAuthUser?.updateEmail(email);
      }
      if (password != null) {
        await firebaseAuthUser?.updatePassword(password);
      }
    } on FirebaseAuthException catch (e) {
      // Handle re-authentication errors
      print('Failed to re-authenticate: ${e.message}');
      // You might want to display an error message to the user here
      return; // Return early if re-authentication fails
    }

    notifyListeners();
  }

  Future<void> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(kUserLoggedInId);
    if (userId != null) {
      dbUser = await MyUserDao.getUser(userId);
      // firebaseAuthUser =
      //     FirebaseAuth.instance.currentUser; // Set the firebaseAuthUser
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        dbUser = await MyUserDao.getUser(currentUser.uid);
        firebaseAuthUser = currentUser;
      }
      notifyListeners(); // Notify listeners to update the UI
    }
  }
}
