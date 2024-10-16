import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Ingredients.dart';

class IngredientsModel {
  String food = '';
  String image = '';
  double quantity = 0.0;
  String measure = '';

  IngredientsModel({
    required this.food,
    required this.image,
    required this.quantity,
    required this.measure,
  });

  IngredientsModel.fromJson(dynamic json) {
    quantity = json['quantity'];
    food = json['food'];
    measure = json['measure'];
    image = json['image'];
  }

  IngredientsModel copyWith({
    double? quantity,
    String? food,
    String? measure,
    String? image,
  }) =>
      IngredientsModel(
        quantity: quantity ?? this.quantity,
        measure: measure ?? this.measure,
        food: food ?? this.food,
        image: image ?? this.image,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quantity'] = quantity;
    map['measure'] = measure;
    map['food'] = food;
    map['image'] = image;
    return map;
  }

  // Convert IngredientsModel to API model (Ingredients)
  Ingredients toIngredients() {
    return Ingredients(
      food: food,
      image: image,
      quantity: quantity,
      measure: measure,
    );
  }

  // Convert API model (Ingredients) to IngredientsModel for local storage
  factory IngredientsModel.fromIngredients(Ingredients ingredients) {
    return IngredientsModel(
      food: ingredients.food.toString() ?? '',
      image: ingredients.image.toString() ?? '',
      quantity: ingredients.quantity?.toDouble() ?? 0.0,
      measure: ingredients.measure.toString() ?? '',
    );
  }

  // Convert IngredientsModel to Firestore document data
  Map<String, dynamic> toFirestore() {
    return {
      'food': food,
      'image': image,
      'quantity': quantity,
      'measure': measure,
    };
  }

  // Create IngredientsModel from Firestore document data
  factory IngredientsModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return IngredientsModel(
      food: data['food'] ?? '',
      image: data['image'] ?? '',
      quantity: data['quantity']?.toDouble() ?? 0.0,
      measure: data['measure'] ?? '',
    );
  }
}
