import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/core/styles.dart';

typedef Validator = String? Function(String?);

class CustomTextFormField extends StatefulWidget {
  String hintText;
  TextInputType keyboardType;
  Validator? validator;
  TextEditingController? controller;
  int maxLines;
  bool isPassword;
  bool readOnly;
  CustomTextFormField({
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.controller,
    this.maxLines = 1,
    this.isPassword = false,
    this.readOnly = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        //can make validation for inputs in (TextFormField) , but in (TextField) can't.
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword ? _obscureText : false,
        validator: widget.validator,
        controller: widget.controller,
        maxLines: widget.maxLines,
        minLines: widget.maxLines,
        readOnly: widget.readOnly,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hintText,
          hintStyle:
              Styles.textStyle14.copyWith(color: Colors.black38, fontSize: 13),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: kSecondaryColor, width: 0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: kSecondaryColor, width: 0)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 0)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: kSecondaryColor, width: 0)),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
