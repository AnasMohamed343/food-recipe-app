import 'package:recipe_app/data/model/popular_recipes_response/Hits.dart';

abstract class PopularRecipeRepository {
  Future<List<Hits>?> getPopularRecipes(String query);
}
