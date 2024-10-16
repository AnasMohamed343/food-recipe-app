import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/core/styles.dart';

class CartItemCounter extends StatefulWidget {
  const CartItemCounter({Key? key}) : super(key: key);

  @override
  State<CartItemCounter> createState() => _CartItemCounterState();
}

class _CartItemCounterState extends State<CartItemCounter> {
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              if (_quantity > 0) {
                _quantity--;
              }
            });
          },
          icon: Container(
              height: 25.h,
              width: 25.w,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(7), // Rounded corners
              ),
              child: const Icon(
                Icons.remove,
                size: 20,
              )),
        ),
        Text(
          _quantity.toString(),
          style: Styles.textStyle18,
        ),
        IconButton(
          onPressed: () {
            setState(() {
              _quantity++;
            });
          },
          icon: Container(
              height: 25.h,
              width: 25.w,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(7), // Rounded corners
              ),
              child: const Icon(Icons.add, size: 20)),
        ),
      ],
    );
  }
}
