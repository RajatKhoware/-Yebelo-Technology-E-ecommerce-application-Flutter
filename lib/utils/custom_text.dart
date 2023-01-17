import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color colors;
  final double fontsize;
  final FontWeight fontWeight;
  final int? maxLines;
  final TextOverflow? overFlow;

  const CustomText({
    Key? key,
    required this.text,
    required this.colors,
    required this.fontsize,
    required this.fontWeight,
    this.maxLines,
    this.overFlow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
          color: colors,
          fontWeight: fontWeight,
          fontSize: fontsize,
          overflow: overFlow,
          fontFamily: "Rutan"),
    );
  }
}