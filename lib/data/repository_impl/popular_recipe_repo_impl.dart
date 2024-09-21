import 'package:injectable/injectable.dart';
import 'package:recipe_app/data/datasource_contract/popular_recipe_datasource.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Hits.dart';
import 'package:recipe_app/data/repository_contract/popular_recipe_repository.dart';

@Injectable(as: PopularRecipeRepository)
class PopularRecipeRepoImpl extends PopularRecipeRepository {
  PopularRecipeDatasource popularRecipeDatasource;
  @factoryMethod
  PopularRecipeRepoImpl({required this.popularRecipeDatasource});

  @override
  Future<List<Hits>?> getPopularRecipes(String query) {
    return popularRecipeDatasource.getPopularRecipes(query);
  }
}
