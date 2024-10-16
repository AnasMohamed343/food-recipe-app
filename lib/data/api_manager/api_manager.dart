import 'package:injectable/injectable.dart';
import 'package:recipe_app/data/model/popular_recipes_response/RecipeResponse.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

@singleton
class ApiManager {
  // Base URL without the leading slash
  static String baseUrl = 'api.edamam.com';
  String apiKey = 'a7c04942e1164a30bd5e2159e7a25715';
  String appID = '9a84d53d';

  Future<RecipeResponse> getRecipeResponse(String query) async {
    var uri = Uri.https(baseUrl, '/search', {
      'q': query,
      'app_id': appID,
      'app_key': apiKey,
      'from': '0',
      'to': '100',
      // 'calories': '591-722',
      // 'health': 'alcohol-free'
    });

    var response = await http.get(uri);

    // Print the response body for debugging
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      RecipeResponse recipeResponse = RecipeResponse.fromJson(json);
      return recipeResponse;
    } else {
      throw Exception('Failed to load: ${response.statusCode}');
    }
  }
}
