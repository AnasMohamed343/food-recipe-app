import 'package:injectable/injectable.dart';
import 'package:recipe_app/data/api_manager/api_manager.dart';
import 'package:recipe_app/data/datasource_contract/popular_recipe_datasource.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Hits.dart';

@Injectable(as: PopularRecipeDatasource)
class PopularRecipeDatasourceImpl extends PopularRecipeDatasource {
  ApiManager apiManager;
  @factoryMethod
  PopularRecipeDatasourceImpl({required this.apiManager});
  @override
  Future<List<Hits>?> getPopularRecipes(String query) async {
    var response = await apiManager.getRecipeResponse(query);
    return response.hits;
  }
}
