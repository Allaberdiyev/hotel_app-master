import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Icon ikon;
  final VoidCallback onTap;
  const Tile({
    super.key,

    required this.ikon,
    required this.subtitle,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(child: ikon),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: TextStyle()),
    );
  }
}
