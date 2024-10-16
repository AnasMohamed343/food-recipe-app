import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/Constants.dart';

class CircleProfilePicture extends StatelessWidget {
  double? width, height;
  String imageUrl;
  CircleProfilePicture(
      {super.key, this.width, this.height, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   padding: const EdgeInsets.all(10),
    //   width: width,
    //   height: height,
    //   decoration: BoxDecoration(
    //     border: Border.all(color: Colors.white, width: 2),
    //     shape: BoxShape.circle,
    //     color: Colors.white,
    //     image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.fill),
    //   ),
    // );
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: ClipOval(
        child: Image.network(
          imageUrl,
          width: width,
          height: height,
          fit: BoxFit.fill,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              // Image loaded successfully
              return child;
            } else {
              // Image still loading
              return Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                ),
              );
            }
          },
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            // Handle image loading errors
            return const Center(
              child: Icon(Icons.error),
            );
          },
          cacheHeight: 200,
          cacheWidth: 200,
        ),
      ),
    );
  }
}
