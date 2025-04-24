import 'package:flutter/material.dart';

class TextItem extends StatelessWidget {
  const TextItem({
    super.key,
    required this.text,

    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
  });
  final String text;

  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: fontWeight, fontSize: fontSize),
    );
  }
}
