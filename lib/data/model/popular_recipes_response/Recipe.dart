import 'Ingredients.dart';
import 'TotalNutrients.dart';
import 'TotalDaily.dart';
import 'Digest.dart';

class Recipe {
  Recipe({
    this.uri,
    this.label,
    this.image,
    this.source,
    this.url,
    this.shareAs,
    this.yield,
    this.dietLabels,
    this.healthLabels,
    this.cautions,
    this.ingredientLines,
    this.ingredients,
    this.calories,
    this.totalWeight,
    this.totalTime,
    this.cuisineType,
    this.mealType,
    this.dishType,
    this.totalNutrients,
    this.totalDaily,
    this.digest,
  });

  Recipe.fromJson(dynamic json) {
    uri = json['uri'];
    label = json['label'];
    image = json['image'];
    source = json['source'];
    url = json['url'];
    shareAs = json['shareAs'];
    yield = json['yield'];
    dietLabels =
        json['dietLabels'] != null ? json['dietLabels'].cast<String>() : [];
    healthLabels =
        json['healthLabels'] != null ? json['healthLabels'].cast<String>() : [];
    if (json['cautions'] != null) {
      cautions = [];
      json['cautions'].forEach((v) {
        cautions?.add(v);
      });
    }
    ingredientLines = json['ingredientLines'] != null
        ? json['ingredientLines'].cast<String>()
        : [];
    if (json['ingredients'] != null) {
      ingredients = [];
      json['ingredients'].forEach((v) {
        ingredients?.add(Ingredients.fromJson(v));
      });
    }
    calories = json['calories'];
    totalWeight = json['totalWeight'];
    totalTime = json['totalTime'];
    cuisineType =
        json['cuisineType'] != null ? json['cuisineType'].cast<String>() : [];
    mealType = json['mealType'] != null ? json['mealType'].cast<String>() : [];
    dishType = json['dishType'] != null ? json['dishType'].cast<String>() : [];
    totalNutrients = json['totalNutrients'] != null
        ? TotalNutrients.fromJson(json['totalNutrients'])
        : null;
    totalDaily = json['totalDaily'] != null
        ? TotalDaily.fromJson(json['totalDaily'])
        : null;
    if (json['digest'] != null) {
      digest = [];
      json['digest'].forEach((v) {
        digest?.add(Digest.fromJson(v));
      });
    }
  }
  String? uri;
  String? label;
  String? image;
  String? source;
  String? url;
  String? shareAs;
  double? yield;
  List<String>? dietLabels;
  List<String>? healthLabels;
  List<dynamic>? cautions;
  List<String>? ingredientLines;
  List<Ingredients>? ingredients;
  double? calories;
  double? totalWeight;
  double? totalTime;
  List<String>? cuisineType;
  List<String>? mealType;
  List<String>? dishType;
  TotalNutrients? totalNutrients;
  TotalDaily? totalDaily;
  List<Digest>? digest;
  Recipe copyWith({
    String? uri,
    String? label,
    String? image,
    String? source,
    String? url,
    String? shareAs,
    double? yield,
    List<String>? dietLabels,
    List<String>? healthLabels,
    List<dynamic>? cautions,
    List<String>? ingredientLines,
    List<Ingredients>? ingredients,
    double? calories,
    double? totalWeight,
    double? totalTime,
    List<String>? cuisineType,
    List<String>? mealType,
    List<String>? dishType,
    TotalNutrients? totalNutrients,
    TotalDaily? totalDaily,
    List<Digest>? digest,
  }) =>
      Recipe(
        uri: uri ?? this.uri,
        label: label ?? this.label,
        image: image ?? this.image,
        source: source ?? this.source,
        url: url ?? this.url,
        shareAs: shareAs ?? this.shareAs,
        yield: yield ?? this.yield,
        dietLabels: dietLabels ?? this.dietLabels,
        healthLabels: healthLabels ?? this.healthLabels,
        cautions: cautions ?? this.cautions,
        ingredientLines: ingredientLines ?? this.ingredientLines,
        ingredients: ingredients ?? this.ingredients,
        calories: calories ?? this.calories,
        totalWeight: totalWeight ?? this.totalWeight,
        totalTime: totalTime ?? this.totalTime,
        cuisineType: cuisineType ?? this.cuisineType,
        mealType: mealType ?? this.mealType,
        dishType: dishType ?? this.dishType,
        totalNutrients: totalNutrients ?? this.totalNutrients,
        totalDaily: totalDaily ?? this.totalDaily,
        digest: digest ?? this.digest,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uri'] = uri;
    map['label'] = label;
    map['image'] = image;
    map['source'] = source;
    map['url'] = url;
    map['shareAs'] = shareAs;
    map['yield'] = yield;
    map['dietLabels'] = dietLabels;
    map['healthLabels'] = healthLabels;
    if (cautions != null) {
      map['cautions'] = cautions?.map((v) => v.toJson()).toList();
    }
    map['ingredientLines'] = ingredientLines;
    if (ingredients != null) {
      map['ingredients'] = ingredients?.map((v) => v.toJson()).toList();
    }
    map['calories'] = calories;
    map['totalWeight'] = totalWeight;
    map['totalTime'] = totalTime;
    map['cuisineType'] = cuisineType;
    map['mealType'] = mealType;
    map['dishType'] = dishType;
    if (totalNutrients != null) {
      map['totalNutrients'] = totalNutrients?.toJson();
    }
    if (totalDaily != null) {
      map['totalDaily'] = totalDaily?.toJson();
    }
    if (digest != null) {
      map['digest'] = digest?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
