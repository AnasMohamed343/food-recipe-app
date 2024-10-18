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
