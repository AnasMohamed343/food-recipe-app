import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Features/category_screen/presentation/views/recipes_based_on_category.dart';
import 'package:recipe_app/Features/category_screen/presentation/views/widgets/custom_item_based_on_category.dart';
import 'package:recipe_app/Features/search/presentation/views/widgets/serach_tags.dart';
import 'package:recipe_app/Features/search/presentation/views/widgets/text_field_widget.dart';
import 'package:recipe_app/core/styles.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const TextFieldWidget(),
          const SizedBox(
            height: 18,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              textAlign: TextAlign.start,
              'Search Tags',
              style: Styles.textStyle20,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Wrap(
                alignment: WrapAlignment.spaceAround,
                spacing: 8,
                runSpacing: 6,
                children: tags.map((label) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: kPrimaryColor,
                        //backgroundColor: kPrimaryColor.withOpacity(0.7),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RecipesBasedOnCategory(recipe: label)));
                      },
                      child: Text(label));
                }).toList()),
          ),
        ],
      ),
    );
  }
}
