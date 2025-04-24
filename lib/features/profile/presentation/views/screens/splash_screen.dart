import 'package:flutter/material.dart';
import 'package:hotel_app/features/profile/presentation/views/screens/screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void goToLogin(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3));

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) {
            return Screen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    goToLogin(context);
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Text(
          "SafarGo",
          style: TextStyle(
            fontSize: 50,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
