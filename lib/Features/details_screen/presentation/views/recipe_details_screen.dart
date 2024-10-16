import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Features/details_screen/data/models/ingredints_model.dart';
import 'package:recipe_app/Features/details_screen/presentation/views/widgets/custom_details_picture.dart';
import 'package:recipe_app/Features/details_screen/presentation/views/widgets/custom_ingredients_item.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/custom_time_cooking_widget.dart';
import 'package:recipe_app/core/assets.dart';
import 'package:recipe_app/core/styles.dart';
import 'package:recipe_app/core/utiles/reusable_functions.dart';
import 'package:recipe_app/core/utiles/share_recipe.dart';
import 'package:recipe_app/core/utiles/start_cooking.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Hits.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Ingredients.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Recipe.dart';
import 'package:recipe_app/provider/cart_model.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final Hits hits;
  const RecipeDetailsScreen({super.key, required this.hits});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    String formattedTime = ReusableFunctions.formatTotalTime(
        widget.hits.recipe?.totalTime?.toInt().toString() ?? '0');
    return Consumer<CartModel>(
      builder: (context, cartModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDetailsPicture(
                    hits: widget.hits,
                  ),
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 280.w,
                              child: Text(widget.hits.recipe?.label ?? '',
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Styles.textStyle20),
                            ),
                            const Spacer(),
                            CustomTimeCookingWidget(
                              text: formattedTime,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildNutritionalInfo(
                                widget.hits.recipe?.totalNutrients?.cHOCDFnet
                                        ?.quantity
                                        ?.toInt()
                                        .toString() ??
                                    '0',
                                "carbs",
                                SvgPicture.asset(
                                  Assets.carbIcon,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              _buildNutritionalInfo(
                                  widget.hits.recipe?.totalNutrients?.procnt
                                          ?.quantity
                                          ?.toInt()
                                          .toString() ??
                                      '0',
                                  "Proteins",
                                  SvgPicture.asset(
                                    Assets.proteinIcon,
                                    width: 20,
                                    height: 20,
                                  )),
                              _buildNutritionalInfo(
                                  widget.hits.recipe?.totalNutrients?.enerckcal
                                          ?.quantity
                                          ?.toInt()
                                          .toString() ??
                                      '0',
                                  "Kacl",
                                  SvgPicture.asset(
                                    Assets.caloriesIcon,
                                    color: kSecondaryColor,
                                    width: 20,
                                    height: 20,
                                  )),
                              _buildNutritionalInfo(
                                  widget.hits.recipe?.totalNutrients?.fat
                                          ?.quantity
                                          ?.toInt()
                                          .toString() ??
                                      '0',
                                  "fats",
                                  SvgPicture.asset(
                                    Assets.fatIcon,
                                    width: 20,
                                    height: 20,
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: 23,
                                backgroundColor: Colors.black,
                                child: IconButton(
                                  onPressed: () {
                                    StartCooking.startCooking(
                                        widget.hits.recipe?.url ?? '');
                                  },
                                  icon: SvgPicture.asset(Assets.iconsChefIcon,
                                      width: 25, height: 25),
                                ),
                              ),
                              CircleAvatar(
                                radius: 23,
                                backgroundColor: kPrimaryColor,
                                child: IconButton(
                                  onPressed: () {
                                    ShareRecipe.shareRecipe(
                                        widget.hits.recipe?.url ?? '');
                                  },
                                  icon: const Icon(
                                    IconlyLight.send,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            "Ingredients",
                            style: Styles.textStyle20,
                          ),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.zero,
                          itemCount:
                              widget.hits.recipe?.ingredients?.length ?? 0,
                          itemBuilder: (context, index) {
                            // Get the ingredient from the API response
                            Ingredients ingredient = widget.hits.recipe!
                                .ingredients![index]; //as Ingredients;

                            // Use the factory method to convert Ingredients to IngredientsModel
                            IngredientsModel ingredientModel =
                                IngredientsModel.fromIngredients(ingredient);
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: CustomIngredientsItem(
                                ingredient: ingredientModel,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNutritionalInfo(String value, String label, Widget icon) {
    return Column(
      children: [
        // Row to include the icon and value side by side
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Icon(icon, size: 20, color: Colors.grey), // Icon
            icon,
            const SizedBox(width: 5), // Spacing between icon and value
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5), // Spacing between the row and label
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }
}
