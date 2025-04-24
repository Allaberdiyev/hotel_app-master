import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/features/auth/data/models/auth_model.dart';
import 'package:hotel_app/features/profile/presentation/extension/space_extension.dart';
import 'package:hotel_app/features/auth/presentation/views/screens/login_in_screen.dart';

import '../../../data/datasources/auth_remote_datasources.dart';

class UserEnterInfosScreen extends StatefulWidget {
  final AuthModel user;

  const UserEnterInfosScreen({super.key, required this.user});

  @override
  State<UserEnterInfosScreen> createState() => _UserEnterInfosScreenState();
}

class _UserEnterInfosScreenState extends State<UserEnterInfosScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  String message = '';

  void handleSave() async {
    final updatedUser = AuthModel(
      login: widget.user.login,
      password: widget.user.password,
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      birthDate: birthDateController.text.trim(),
      gender: genderController.text.trim(),
    );

    final success = await AuthRemoteDataSources().updateUserInfos(updatedUser);

    setState(() {
      message =
          success
              ? "data_saved".tr(context: context)
              : "error_occurred".tr(context: context);
    });

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (ctx) => LoginInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('user_info'.tr(context: context))),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              30.h,
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: 'first_name'.tr(context: context),
                  labelStyle: TextStyle(
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
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: 'last_name'.tr(context: context),
                  labelStyle: TextStyle(
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
                controller: birthDateController,
                decoration: InputDecoration(
                  labelText: 'birth_date'.tr(context: context),
                  labelStyle: TextStyle(
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
                controller: genderController,
                decoration: InputDecoration(
                  labelText: 'gender'.tr(context: context),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              30.h,
              TextButton(
                onPressed: handleSave,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'save'.tr(context: context),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              20.h,
              if (message.isNotEmpty)
                Text(
                  message,
                  style: TextStyle(
                    color:
                        message.contains('saved'.tr(context: context))
                            ? Colors.green
                            : Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
