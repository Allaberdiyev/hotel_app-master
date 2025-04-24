import 'package:flutter/material.dart';

class TextItem extends StatelessWidget {
  const TextItem({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
  });
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
