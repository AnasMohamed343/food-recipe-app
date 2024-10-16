// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:recipe_app/Features/component/custom_app_bar.dart';
// import 'package:recipe_app/Features/details_screen/data/provider/cart_model.dart';
// import 'package:recipe_app/Features/details_screen/presentation/views/widgets/custom_ingredients_item.dart';
// import 'package:recipe_app/data/model/popular_recipes_response/Ingredients.dart';
// import 'package:provider/provider.dart';
//
// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});
//
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CartModel>(
//       builder: (context, cartModel, child) {
//         return SafeArea(
//           child: Scaffold(
//             backgroundColor: Colors.white,
//             appBar: const CustomAppBar(title: 'Shopping Cart', back: true),
//             body: SizedBox(
//               height: MediaQuery.of(context).size.height,
//               child: ListView.builder(
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                 itemCount: cartModel.cartItems.length,
//                 itemBuilder: (context, index) {
//                   return CustomIngredientsItem(
//                     ingredients: cartModel.cartItems[index],
//                     onCartChanged: () {
//                       setState(() {}); // Trigger rebuild of CartScreen
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Features/component/custom_app_bar.dart';
import 'package:recipe_app/Features/details_screen/data/models/ingredints_model.dart';
import 'package:recipe_app/Features/details_screen/presentation/views/widgets/custom_ingredients_item.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/core/assets.dart';
import 'package:recipe_app/core/styles.dart';
import 'package:recipe_app/provider/cart_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    List<IngredientsModel> ingredients =
        Provider.of<CartModel>(context).cartItems;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: 'Shopping Cart', back: true),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ingredients.isNotEmpty
              ? ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  itemCount: ingredients.length,
                  itemBuilder: (context, index) {
                    return CustomIngredientsItem(
                      ingredient: ingredients[index],
                    );
                  })
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(image: AssetImage(Assets.emptyCart)),
                      const SizedBox(height: 5),
                      Text(
                        textAlign: TextAlign.center,
                        '   Cart Is Empty',
                        style: Styles.textStyle16
                            .copyWith(color: Colors.blue.shade900),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
