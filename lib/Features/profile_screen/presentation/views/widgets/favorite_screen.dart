import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/Features/component/custom_app_bar.dart';
import 'package:recipe_app/Features/profile_screen/presentation/views/widgets/favorites_gridview.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Favorites',
          back: true,
        ),
        body: const CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: FavoritesGridViewWidget()),
          ],
        ),
      ),
    );
  }
}
