import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Features/home/presentation/view_models/popular_recipe_vm.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/popular_recipes_card.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Hits.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Recipe.dart';
import 'package:recipe_app/di/di.dart';

import 'package:provider/provider.dart';

class PopularRecipesListView extends StatefulWidget {
  final String recipe;
  const PopularRecipesListView({super.key, required this.recipe});

  @override
  State<PopularRecipesListView> createState() => _PopularRecipesListViewState();
}

class _PopularRecipesListViewState extends State<PopularRecipesListView> {
  PopularRecipeViewModel viewModel = getIt.get<PopularRecipeViewModel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getPopularRecipes(widget.recipe);
  }

  @override
  Widget build(BuildContext context) {
    //final favoriteProvider = Provider.of<FavoriteProvider>(context);
    return BlocBuilder<PopularRecipeViewModel, PopularRecipeState>(
      bloc: viewModel,
      builder: (context, state) {
        switch (state) {
          case LoadingState():
            return Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(state.message),
              ],
            ));
          case ErrorState():
            return Center(
                child: Column(children: [
              Text(state.errorMessage ?? ''),
              ElevatedButton(
                  onPressed: () {
                    viewModel.getPopularRecipes(widget.recipe);
                  },
                  child: const Text('Try Again'))
            ]));
          case SuccessState():
            return SizedBox(
              height: 240.h,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: state.hitsList?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: PopularRecipesCard(
                      hits: state.hitsList?[index] as Hits,
                      //favorite: favoriteProvider.favorites[index],
                    ),
                  );
                },
              ),
            );
        }
      },
    );
  }
}
