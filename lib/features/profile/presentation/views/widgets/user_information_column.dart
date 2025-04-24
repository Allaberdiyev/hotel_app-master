import 'package:flutter/material.dart';

class UserInformationColumn extends StatelessWidget {
  final String firstInfo;
  final String secondInfo;
  const UserInformationColumn({
    super.key,
    required this.firstInfo,
    required this.secondInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          firstInfo,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(secondInfo),
      ],
    );
  }
}
