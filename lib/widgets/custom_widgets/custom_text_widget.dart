import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    required this.text,
    this.size,
    this.bold,
    this.color,
    this.textAlign,
    this.textStyle,
    this.fontWeight,
    Key? key,
  }) : super(key: key);
  final String text;
  final double? size;
  final bool? bold;
  final Color? color;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      // overflow: TextOverflow.ellipsis,
      style: textStyle ??
         TextStyle(
            color: color ?? Colors.black,
            fontSize: size,
            fontWeight:fontWeight!=null?fontWeight: bold == true ? FontWeight.w600 : FontWeight.w400,
          ),
    );
  }
}
