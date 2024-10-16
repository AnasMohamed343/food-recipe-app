import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/core/styles.dart';

class DialogUtils {
  static void showLoadingDialog(BuildContext context, String message,
      {bool isDismissable = true}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(
              color: kPrimaryColor,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              message,
              style: Styles.textStyle18
                  .copyWith(color: Colors.white, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        backgroundColor: kSecondaryColor,
      ),
      barrierDismissible: isDismissable,
    );
  }

  // static void hideDialog(BuildContext context) {
  //   Navigator.pop(context);
  // }
  static void hideDialog(BuildContext context) {
    print("Hiding dialog");
    Navigator.of(context, rootNavigator: true).pop();
  }

  static void showMessage(
    BuildContext context,
    String message, {
    String? posActionTitle,
    String? negActionTitle,
    VoidCallback? posAction,
    VoidCallback? negAction,
  }) {
    List<Widget> actions = [];
    if (posActionTitle != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(
            posActionTitle,
            style: Styles.textStyle18.copyWith(color: Colors.green.shade500),
          )));
    }
    if (negActionTitle != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(
            negActionTitle,
            style: Styles.textStyle18.copyWith(color: Colors.red),
          )));
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: kSecondaryColor,
        content: Text(
          message,
          style: Styles.textStyle18
              .copyWith(color: Colors.white, fontWeight: FontWeight.normal),
        ),
        actions: actions,
      ),
    );
  }
}
