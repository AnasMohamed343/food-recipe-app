import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Features/details_screen/data/models/favorite_hits_model.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Hits.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Recipe.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteProvider extends ChangeNotifier {
  List<FavoriteHitsModel> _favorites = [];
  final String userId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FavoriteProvider(this.userId) {
    print('userId now is >>>: $userId');
    _loadFavorites();
  }

  List<Recipe> get favorites {
    return _favorites
        .map((favorite) => Recipe.fromFavoriteRecipe(favorite.recipe))
        .toList();
  }

  Future<void> _loadFavorites() async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .get();
    _favorites = snapshot.docs
        .map((doc) => FavoriteHitsModel.fromFirestore(doc))
        .toList();
    notifyListeners();
  }

  Future<void> toggleFavorite(Hits hits) async {
    final favoriteHitsModel = FavoriteHitsModel.fromHits(hits);
    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(hits.recipe!.label);

    if (isExist(hits)) {
      await docRef.delete();
    } else {
      await docRef.set(favoriteHitsModel.toFirestore());
    }
    _loadFavorites();
  }

  bool isExist(Hits hits) {
    return _favorites.any((f) => f.recipe!.label == hits.recipe!.label);
  }
}
