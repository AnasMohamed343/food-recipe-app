import 'package:recipe_app/Features/details_screen/data/models/ingredints_model.dart';

class Ingredients {
  Ingredients({
    this.text,
    this.quantity,
    this.measure,
    this.food,
    this.weight,
    this.foodCategory,
    this.foodId,
    this.image,
    this.id,
  });

  Ingredients.fromJson(dynamic json) {
    text = json['text'];
    quantity = json['quantity'];
    measure = json['measure'];
    food = json['food'];
    weight = json['weight'];
    foodCategory = json['foodCategory'];
    foodId = json['foodId'];
    image = json['image'];
  }
  String? id;
  String? text;
  double? quantity;
  String? measure;
  String? food;
  double? weight;
  String? foodCategory;
  String? foodId;
  String? image;
  Ingredients copyWith({
    String? text,
    double? quantity,
    String? measure,
    String? food,
    double? weight,
    String? foodCategory,
    String? foodId,
    String? image,
  }) =>
      Ingredients(
        text: text ?? this.text,
        quantity: quantity ?? this.quantity,
        measure: measure ?? this.measure,
        food: food ?? this.food,
        weight: weight ?? this.weight,
        foodCategory: foodCategory ?? this.foodCategory,
        foodId: foodId ?? this.foodId,
        image: image ?? this.image,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    map['quantity'] = quantity;
    map['measure'] = measure;
    map['food'] = food;
    map['weight'] = weight;
    map['foodCategory'] = foodCategory;
    map['foodId'] = foodId;
    map['image'] = image;
    return map;
  }

  factory Ingredients.fromIngredientsModel(IngredientsModel? ingredientsModel) {
    if (ingredientsModel == null)
      return throw ArgumentError('Recipe cannot be null');
    return Ingredients(
      quantity: ingredientsModel.quantity,
      measure: ingredientsModel.measure,
      food: ingredientsModel.food,
      image: ingredientsModel.image,
    );
  }
}
