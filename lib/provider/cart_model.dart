import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Features/details_screen/data/models/ingredints_model.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Ingredients.dart';

// class CartModel extends ChangeNotifier {
//   List<IngredientsModel> _cartItems = [];
//   final String userId; // Add userIdfinal
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   CartModel(this.userId) {
//     // Add userId to constructor
//     _loadCartItems();
//   }
//
//   List<IngredientsModel> get cartItems => _cartItems;
//
//   Future<void> _loadCartItems() async {
//     final snapshot = await _firestore
//         .collection('users')
//         .doc(userId)
//         .collection('cartItems')
//         .get();
//
//     _cartItems = snapshot.docs
//         .map((doc) => IngredientsModel.fromFirestore(doc))
//         .toList();
//     notifyListeners();
//   }
//
//   Future<void> toggleCartItem(IngredientsModel ingredient) async {
//     final docRef = _firestore
//         .collection('users')
//         .doc(userId)
//         .collection('cartItems')
//         .doc(ingredient.food);
//
//     if (isItemInCart(ingredient)) {
//       await docRef.delete();
//       // Show toast message
//       Fluttertoast.showToast(
//         msg: 'Removed from cart!',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM_LEFT,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0.sp,
//       );
//     } else {
//       await docRef.set(ingredient.toFirestore());
//       // Show toast message
//       Fluttertoast.showToast(
//         msg: 'Added to cart!',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         fontSize: 16.0.sp,
//       );
//     }
//     _loadCartItems();
//   }
//
//   bool isItemInCart(IngredientsModel ingredient) {
//     return _cartItems.any((i) => i.food == ingredient.food);
//   }
// }
class CartModel extends ChangeNotifier {
  List<IngredientsModel> _cartItems = [];
  final String userId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CartModel(this.userId) {
    _loadCartItems();
  }

  List<IngredientsModel> get cartItems => _cartItems;

  Future<void> _loadCartItems() async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('cartItems')
        .get();

    _cartItems = snapshot.docs
        .map((doc) => IngredientsModel.fromFirestore(doc))
        .toList();
    notifyListeners();
  }

  Future<void> toggleCartItem(IngredientsModel ingredient) async {
    // if (ingredient.food.isEmpty) {
    //   throw Exception('Ingredient food cannot be empty');
    // }
    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('cartItems')
        .doc(ingredient.food);

    if (isItemInCart(ingredient)) {
      // Optimistically remove from local cart items
      _cartItems.removeWhere((i) => i.food == ingredient.food);
      notifyListeners(); // Update UI immediately
      await docRef.delete(); // Delete from Firestore

      // Show toast message
      Fluttertoast.showToast(
        msg: 'Removed from cart!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM_LEFT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0.sp,
      );
    } else {
      // Optimistically add to local cart items
      _cartItems.add(ingredient);
      notifyListeners(); // Update UI immediately
      await docRef.set(ingredient.toFirestore()); // Add to Firestore

      // Show toast message
      Fluttertoast.showToast(
        msg: 'Added to cart!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0.sp,
      );
    }
  }

  bool isItemInCart(IngredientsModel ingredient) {
    return _cartItems.any((i) => i.food == ingredient.food);
  }
}
