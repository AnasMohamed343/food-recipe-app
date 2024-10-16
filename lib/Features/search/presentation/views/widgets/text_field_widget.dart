import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Features/category_screen/presentation/views/recipes_based_on_category.dart';
import 'package:recipe_app/core/styles.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 27, horizontal: 15),
      child: Container(
        height: 55.h,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
          BoxShadow(
            color: Colors.black26.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ]),
        child: TextField(
          controller: search,
          style: Styles.textStyle16.copyWith(fontWeight: FontWeight.normal),
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Search for recipes',
            hintStyle: Styles.textStyle16
                .copyWith(fontWeight: FontWeight.normal, color: Colors.grey),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            suffixIcon: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RecipesBasedOnCategory(recipe: search.text),
                      ));
                },
                child: const Icon(
                  IconlyLight.search,
                  color: kPrimaryColor,
                )),
          ),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        ),
      ),
    );
  }
}
