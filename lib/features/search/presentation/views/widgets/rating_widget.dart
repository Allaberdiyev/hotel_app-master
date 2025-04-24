import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({super.key, required this.rating});
  final int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 1,
      children: List.generate(
        5,
        (index) => Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.white,
          shadows: [
            Shadow(
              blurRadius: 3,
              color: Colors.black.withValues(alpha: 0.4),
              offset: Offset(0, 2),
            ),
          ],
          size: 15,
        ),
      ),
    );
  }
}
