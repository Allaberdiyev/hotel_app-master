import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const RichTextWidget({
    super.key,
    required this.subtitle,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$subtitle: ",
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: title,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.grey[700],
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
