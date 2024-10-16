import 'package:flutter/material.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/popular_recipes_card.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Hits.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Recipe.dart';

import 'package:provider/provider.dart';
import 'package:recipe_app/provider/favorite_provider.dart';

class FavoritesGridViewWidget extends StatefulWidget {
  const FavoritesGridViewWidget({super.key});

  @override
  State<FavoritesGridViewWidget> createState() =>
      _FavoritesGridViewWidgetState();
}

class _FavoritesGridViewWidgetState extends State<FavoritesGridViewWidget> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    List<Recipe> recipes = Provider.of<FavoriteProvider>(context).favorites;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
      ),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        Recipe recipe = recipes[index];
        Hits hits = Hits(recipe: recipe);
        return Padding(
          padding: const EdgeInsets.all(7),
          child: PopularRecipesCard(
            recipe: recipe,
            hits: hits,
          ),
        );
      },
    );
  }
}
