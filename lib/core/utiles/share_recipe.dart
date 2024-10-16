import 'package:share_plus/share_plus.dart';

class ShareRecipe {
  static shareRecipe(String recipeLink) async {
    await Share.share(recipeLink);
  }
}
