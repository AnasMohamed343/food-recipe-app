import 'Recipe.dart';

import 'package:hive/hive.dart';

class Hits extends HiveObject {
  Hits({
    this.recipe,
    this.userId,
  });

  Hits.fromJson(dynamic json) {
    recipe = json['recipe'] != null ? Recipe.fromJson(json['recipe']) : null;
  }
  Recipe? recipe;
  String? userId;
  Hits copyWith({
    Recipe? recipe,
  }) =>
      Hits(
        recipe: recipe ?? this.recipe,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (recipe != null) {
      map['recipe'] = recipe?.toJson();
    }
    return map;
  }
}
//
// class Hits extends HiveObject {
//   Hits({
//     this.recipe,
//   });
//
//   Hits.fromJson(dynamic json) {
//     recipe =
//         json['recipe'] != null ? FavoriteRecipe.fromJson(json['recipe']) : null;
//   }
//   FavoriteRecipe? recipe;
//   Hits copyWith({
//     FavoriteRecipe? recipe,
//   }) =>
//       Hits(
//         recipe: recipe ?? this.recipe,
//       );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (recipe != null) {
//       map['recipe'] = recipe?.toJson();
//     }
//     return map;
//   }
// }
