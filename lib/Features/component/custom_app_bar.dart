import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/core/styles.dart';
import 'package:recipe_app/core/utiles/routes_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool back;
  Color? backgroundColor;
  List<Widget>? actions;
  double? elevation;
  Color? arrowBackColor;
  CustomAppBar({
    super.key,
    this.title,
    this.back = false,
    this.actions,
    this.backgroundColor = kPrimaryColor,
    this.elevation,
    this.arrowBackColor = Colors.white,
  });

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      actions: actions,
      elevation: elevation,
      title: Text(
        title ?? '',
        style: Styles.textStyle24,
      ),
      centerTitle: true,
      backgroundColor: backgroundColor,
      titleTextStyle: Styles.textStyle20.copyWith(color: Colors.white),
      leading: back
          ? BackButton(
              color: arrowBackColor,
            )
          : null,
    );
  }
}
