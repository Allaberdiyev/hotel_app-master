import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/features/auth/data/models/auth_model.dart';
import 'package:hotel_app/features/auth/presentation/views/screens/login_in_screen.dart';
import 'package:hotel_app/features/auth/presentation/views/screens/user_enter_infos_screen.dart';
import 'package:hotel_app/features/profile/presentation/extension/space_extension.dart';

import '../../../data/datasources/auth_remote_datasources.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final AuthRemoteDataSources userAuthController = AuthRemoteDataSources();

  String errorMessage = '';

  void handleSignUp() async {
    final login = loginController.text.trim();
    final password = passwordController.text;
    final rePassword = rePasswordController.text;

    if (login.isEmpty || password.isEmpty || rePassword.isEmpty) {
      setState(() {
        errorMessage = "fill_all_information".tr(context: context);
      });
      return;
    }

    if (password != rePassword) {
      setState(() {
        errorMessage = "passwords_not_match".tr(context: context);
      });
      return;
    }

    final newUser = AuthModel(login: login, password: password);

    await userAuthController.addUser(newUser);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (ctx) => UserEnterInfosScreen(user: newUser)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Align(
          alignment: const Alignment(0, -0.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              50.h,
              TextField(
                controller: loginController,
                decoration: InputDecoration(
                  hintText: 'enter_email_or_number'.tr(context: context),
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              20.h,
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'enter_password'.tr(context: context),
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              20.h,
              TextField(
                controller: rePasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 're_enter_password'.tr(context: context),
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              if (errorMessage.isNotEmpty) ...[
                10.h,
                Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              ],
              20.h,
              TextButton(
                onPressed: handleSignUp,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size(350, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'next'.tr(context: context),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 3,
                    color: Colors.white,
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  overlayColor: Colors.transparent,
                  minimumSize: const Size(10, 20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => const LoginInScreen()),
                  );
                },
                child: Align(
                  alignment: Alignment(1, 1),
                  child: Text(
                    'have_you_login_in'.tr(context: context),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: -1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
