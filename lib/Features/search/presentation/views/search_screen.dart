import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Features/component/custom_app_bar.dart';
import 'package:recipe_app/core/styles.dart';

import 'widgets/search_view_body.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Search', back: false),
      body: const SearchViewBody(),
    );
  }
}
