import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Hits.dart';
import 'package:recipe_app/data/repository_contract/popular_recipe_repository.dart';

@injectable
class PopularRecipeViewModel extends Cubit<PopularRecipeState> {
  PopularRecipeRepository popularRecipeRepository;
  @factoryMethod
  PopularRecipeViewModel({required this.popularRecipeRepository})
      : super(LoadingState(message: 'Loading..'));

  void getPopularRecipes(String query) async {
    try {
      var response = await popularRecipeRepository.getPopularRecipes(query);
      print('API Response: $response');
      emit(SuccessState(hitsList: response));
    } catch (e) {
      print('Error fetching recipes: $e');
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}

sealed class PopularRecipeState {}

class LoadingState extends PopularRecipeState {
  String message;
  LoadingState({required this.message});
}

class ErrorState extends PopularRecipeState {
  String? errorMessage;
  ErrorState({this.errorMessage});
}

class SuccessState extends PopularRecipeState {
  List<Hits>? hitsList;
  SuccessState({this.hitsList});
}
