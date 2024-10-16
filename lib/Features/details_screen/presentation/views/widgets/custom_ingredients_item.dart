import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Features/details_screen/data/models/ingredints_model.dart';
import 'package:recipe_app/core/styles.dart';
import 'package:recipe_app/data/model/popular_recipes_response/Ingredients.dart';
import 'package:recipe_app/provider/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomIngredientsItem extends StatelessWidget {
  final IngredientsModel ingredient;
  //final VoidCallback onCartChanged;
  const CustomIngredientsItem({
    super.key,
    required this.ingredient,
    //required this.onCartChanged,
  });

  // bool _isInCart = false;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartModel>(context);
    return AspectRatio(
      aspectRatio: MediaQuery.of(context).size.width / 120.h,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 10.h),
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.withOpacity(0.09),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26.withOpacity(0.09),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(children: [
          AspectRatio(
            aspectRatio: 0.86 / 0.85,
            child: Container(
              height: 80.h,
              width: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    ingredient.image ?? 'https://via.placeholder.com/150',
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  ingredient.food,
                  style: Styles.textStyle18,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  '${ingredient.quantity.toInt()} ${ingredient.measure}',
                  style: Styles.textStyle16
                      .copyWith(fontWeight: FontWeight.normal),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              cartProvider.toggleCartItem(ingredient);
            },
            child: Icon(
              cartProvider.isItemInCart(ingredient)
                  ? Icons.done_outline
                  : Icons.add_circle_outline_outlined,
              size: 27.sp,
              color: cartProvider.isItemInCart(ingredient)
                  ? Colors.green
                  : kPrimaryColor,
            ),
          ),
        ]),
      ),
    );
  }
}

//
// class CustomIngredientsItem extends StatefulWidget {
//   final IngredientsModel ingredients;
//   //final VoidCallback onCartChanged;
//   const CustomIngredientsItem({
//     super.key,
//     required this.ingredients,
//     //required this.onCartChanged,
//   });
//
//   @override
//   State<CustomIngredientsItem> createState() => _CustomIngredientsItemState();
// }
//
// class _CustomIngredientsItemState extends State<CustomIngredientsItem> {
//   // bool _isInCart = false;
//   // //late bool _isInCart;
//   //
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   WidgetsBinding.instance.addPostFrameCallback((_) {
//   //     _checkCartStatus();
//   //   });
//   // }
//   //
//   // // void _checkCartStatus() {
//   // //   var cartModel = Provider.of<CartModel>(context, listen: false);
//   // //   setState(() {
//   // //     _isInCart = cartModel.getCartStatus(widget.ingredients.food ?? '');
//   // //   });
//   // // }
//   //
//   // void _toggleCartStatus() {
//   //   CartModel cartModel = Provider.of<CartModel>(context, listen: false);
//   //   setState(() {
//   //     _isInCart = !_isInCart;
//   //     //cartModel.saveCartStatus(widget.ingredients, _isInCart);
//   //     cartModel.setCartStatus(widget.ingredients, _isInCart);
//   //   });
//   //   if (_isInCart) {
//   //     cartModel.addItem(widget.ingredients, context);
//   //     Fluttertoast.showToast(
//   //       msg: 'Added to cart!',
//   //       toastLength: Toast.LENGTH_SHORT,
//   //       gravity: ToastGravity.BOTTOM,
//   //       timeInSecForIosWeb: 1,
//   //       backgroundColor: Colors.green,
//   //       textColor: Colors.white,
//   //       fontSize: 16.0.sp,
//   //     );
//   //   } else {
//   //     cartModel.removeItem(widget.ingredients);
//   //     Fluttertoast.showToast(
//   //       msg: 'Removed from cart!',
//   //       toastLength: Toast.LENGTH_SHORT,
//   //       gravity: ToastGravity.BOTTOM_LEFT,
//   //       timeInSecForIosWeb: 1,
//   //       backgroundColor: Colors.red,
//   //       textColor: Colors.white,
//   //       fontSize: 16.0.sp,
//   //     );
//   //   }
//   //   widget.onCartChanged();
//   //
//   //   //cartModel.saveCartStatus(_isInCart);
//   // }
//   //
//   // void _checkCartStatus() {
//   //   CartModel cartModel = Provider.of<CartModel>(context, listen: false);
//   //   setState(() {
//   //     _isInCart = cartModel
//   //         .getCartStatus(widget.ingredients); // Get cart status from CartModel
//   //   });
//   // }
//   // // void _checkCartStatus() {
//   // //   CartModel cartModel = Provider.of<CartModel>(context, listen: false);
//   // //   setState(() {
//   // //     _isInCart = cartModel.getCartStatus(widget.ingredients);
//   // //   });
//   // // }
//   //
//   // // Future<void> _saveCartStatus(bool isInCart) async {
//   // //   final prefs = await SharedPreferences.getInstance();
//   // //   await prefs.setBool('${widget.ingredients.food}_isInCart', isInCart);
//   // // }
//   // //
//   // // Future<void> _loadCartStatus() async {
//   // //   final prefs = await SharedPreferences.getInstance();
//   // //   setState(() {
//   // //     _isInCart = prefs.getBool('${widget.ingredients.food}_isInCart') ?? false;
//   // //   });
//   // // }
//   //
//   // // void _toggleCartStatus() {
//   // //   var cartModel = Provider.of<CartModel>(context, listen: false);
//   // //   if (cartModel.getCartStatus(widget.ingredients.id ?? '')) {
//   // //     cartModel.removeItem(widget.ingredients).then((_) {
//   // //       ScaffoldMessenger.of(context).showSnackBar(
//   // //         const SnackBar(
//   // //           backgroundColor: kPrimaryColor,
//   // //           content: Text('Removed from cart!'),
//   // //         ),
//   // //       );
//   // //       _checkCartStatus(); // Update _isInCart after removing
//   // //     });
//   // //   } else {
//   // //     cartModel.addItem(widget.ingredients).then((_) {
//   // //       ScaffoldMessenger.of(context).showSnackBar(
//   // //         const SnackBar(
//   // //           backgroundColor: kPrimaryColor,
//   // //           content: Text('Added to cart!'),
//   // //         ),
//   // //       );
//   // //       _checkCartStatus(); // Update _isInCart after adding
//   // //     });
//   // //   }
//   // //   widget.onCartChanged();
//   // // }
//   // //
//   // // void _checkCartStatus() {
//   // //   var cartModel = Provider.of<CartModel>(context, listen: false);
//   // //   setState(() {
//   // //     _isInCart = cartModel.getCartStatus(widget.ingredients);
//   // //   });
//   // // }
//   //
//   // // void _checkCartStatus() {
//   // //   WidgetsBinding.instance.addPostFrameCallback((_) {
//   // //     var cartModel = Provider.of<CartModel>(context, listen: false);
//   // //     setState(() {
//   // //       _isInCart = cartModel.cartItems
//   // //           .any((item) => item.food == widget.ingredients.food);
//   // //     });
//   // //   });
//   // // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CartModel>(
//       builder: (context, cartModel, child) {
//         //_checkCartStatus();
//         //_isInCart = cartModel.getCartStatus(widget.ingredients);
//         return AspectRatio(
//           aspectRatio: MediaQuery.of(context).size.width / 120.h,
//           child: Container(
//             padding: const EdgeInsets.all(12),
//             margin: EdgeInsets.only(bottom: 10.h),
//             height: 120.h,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(
//                 color: Colors.grey.withOpacity(0.09),
//                 width: 1.0,
//               ),
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black26.withOpacity(0.09),
//                   blurRadius: 12,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Row(children: [
//               AspectRatio(
//                 aspectRatio: 0.86 / 0.85,
//                 child: Container(
//                   height: 80.h,
//                   width: 80.w,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     image: DecorationImage(
//                       fit: BoxFit.fill,
//                       image: NetworkImage(
//                         widget.ingredients.image ??
//                             'https://via.placeholder.com/150',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 width: 20,
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.5,
//                     child: Text(
//                       widget.ingredients.food,
//                       style: Styles.textStyle18,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.5,
//                     child: Text(
//                       '${widget.ingredients.quantity.toInt()} ${widget.ingredients.measure}',
//                       style: Styles.textStyle16
//                           .copyWith(fontWeight: FontWeight.normal),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               GestureDetector(
//                 onTap: _toggleCartStatus,
//                 child: Icon(
//                   _isInCart
//                       ? Icons.done_outline
//                       : Icons.add_circle_outline_outlined,
//                   size: 27.sp,
//                   color: _isInCart ? Colors.green : kPrimaryColor,
//                 ),
//               ),
//             ]),
//           ),
//         );
//       },
//     );
//   }
// }
