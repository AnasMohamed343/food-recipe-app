import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Features/category_screen/presentation/views/widgets/custom_item_based_on_category.dart';
import 'package:recipe_app/Features/component/custom_app_bar.dart';
import 'package:recipe_app/Features/home/presentation/view_models/popular_recipe_vm.dart';
import 'package:recipe_app/di/di.dart';

class RecipesBasedOnCategory extends StatefulWidget {
  final String recipe;
  const RecipesBasedOnCategory({super.key, required this.recipe});

  @override
  State<RecipesBasedOnCategory> createState() => _RecipesBasedOnCategoryState();
}

class _RecipesBasedOnCategoryState extends State<RecipesBasedOnCategory> {
  PopularRecipeViewModel viewModel = getIt.get<PopularRecipeViewModel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getPopularRecipes(widget.recipe);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '${widget.recipe} Recipes', back: true),
      body: BlocBuilder<PopularRecipeViewModel, PopularRecipeState>(
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
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // crossAxisSpacing: 10.w,
                      // mainAxisSpacing: 5.h,
                      childAspectRatio: .6 / 1),
                  itemBuilder: (context, index) {
                    return CustomItemBasedOnCategory(
                        hits: state.hitsList![index]);
                  },
                  itemCount: state.hitsList!.length);
          }
        },
      ),
    );
  }
}
