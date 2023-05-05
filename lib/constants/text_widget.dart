import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.label,
    this.fontSize = 18,
    this.color,
    this.fontWeight,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  final String label;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        color: color ?? Colors.white,
        fontSize: fontSize,
        fontFamily: 'Gilroy',
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    );
  }
}
