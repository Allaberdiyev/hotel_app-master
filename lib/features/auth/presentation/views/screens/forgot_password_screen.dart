import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../data/datasources/auth_remote_datasources.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final AuthRemoteDataSources authController = AuthRemoteDataSources();

  String message = '';

  void resetPassword() async {
    final login = loginController.text.trim();
    final newPassword = newPasswordController.text;

    if (login.isEmpty || newPassword.isEmpty) {
      setState(() {
        message = 'fill_all_fields'.tr(context: context);
      });
      return;
    }

    try {
      await authController.updatePassword(login, newPassword);
      setState(() {
        message = 'password_updated'.tr(context: context);
      });

      loginController.clear();
      newPasswordController.clear();

      Navigator.pop(context);
    } catch (e) {
      setState(() {
        message = 'login_not_found'.tr(context: context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'forgot_password'.tr(context: context),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: loginController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'email_or_number'.tr(context: context),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: newPasswordController,
              decoration: InputDecoration(
                labelText: 'password'.tr(context: context),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: Size(300, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: resetPassword,
              child: Text(
                'update_password'.tr(context: context),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: TextStyle(
                color:
                    message.contains('success'.tr(context: context))
                        ? Colors.green
                        : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
