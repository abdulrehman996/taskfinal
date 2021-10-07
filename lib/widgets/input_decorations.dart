import 'package:flutter/material.dart';

import '../utility/colors.dart';

class InputDecorations {
  static InputDecoration buildInputDecoration_1({hintText = ""}) {
    return InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: MyColor.white,
        hintStyle: TextStyle(fontSize: 12.0, color: MyColor.text_field_grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: MyColor.noColor,
              width: 0.2),
          borderRadius: const BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: MyColor.accent_color,
              width: 0.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0));
  }

  static InputDecoration buildInputDecoration_phone({hintText = ""}) {
    return InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 12.0, color: MyColor.text_field_grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColor.text_field_grey, width: 0.5),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(6.0),
              bottomRight: Radius.circular(6.0)),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColor.accent_color, width: 0.5),
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(6.0),
                bottomRight: Radius.circular(6.0))),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0));
  }
}
