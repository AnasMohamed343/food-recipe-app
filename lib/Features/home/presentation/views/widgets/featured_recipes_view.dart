import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Features/home/presentation/view_models/popular_recipe_vm.dart';
import 'package:recipe_app/Features/home/presentation/views/widgets/featured_card_item.dart';
import 'package:recipe_app/di/di.dart';

class FeaturedRecipesView extends StatefulWidget {
  final String recipe;
  const FeaturedRecipesView({super.key, required this.recipe});

  @override
  State<FeaturedRecipesView> createState() => _FeaturedRecipesViewState();
}

class _FeaturedRecipesViewState extends State<FeaturedRecipesView> {
  PopularRecipeViewModel viewModel = getIt.get<PopularRecipeViewModel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getPopularRecipes(widget.recipe);
  }

  @override
  Widget build(BuildContext context) {
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
            return CarouselSlider.builder(
              itemCount: state.hitsList!.length,
              itemBuilder: (context, index, realIndex) {
                return Padding(
                  padding: const EdgeInsets.only(right: 14, left: 6),
                  child: FeaturedCardItem(
                    hits: state.hitsList![index],
                  ),
                );
              },
              options: CarouselOptions(
                height: 200.h,
                enlargeCenterPage: true,
                autoPlay: false,
                autoPlayInterval: const Duration(seconds: 10),
                aspectRatio: 20 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(seconds: 5),
                viewportFraction: 1,
              ),
            );
        }
      },
    );
  }
}
