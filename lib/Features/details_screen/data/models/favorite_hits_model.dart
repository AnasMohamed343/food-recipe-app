import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Hits.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Recipe.dart';

class FavoriteHitsModel {
  final Recipe? recipe;
  final String userId;

  FavoriteHitsModel({this.recipe, required this.userId});

  factory FavoriteHitsModel.fromHits(Hits hits) {
    return FavoriteHitsModel(recipe: hits.recipe, userId: hits.userId ?? '');
  }

  factory FavoriteHitsModel.fromFirestore(DocumentSnapshot doc) {
    return FavoriteHitsModel(
      recipe: Recipe.fromMap(doc.data() as Map<String, dynamic>),
      userId: doc.id,
    );
  }

  Map<String, dynamic> toFirestore() {
    return recipe!.toMap();
  }
}
