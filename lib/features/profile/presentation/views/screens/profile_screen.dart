import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/features/profile/presentation/extension/space_extension.dart';

import '../../../data/models/profile_model.dart';
import '../../viewmodels/profile_viewmodel.dart';
import '../widgets/field.dart';
import '../widgets/user_information_column.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final genderController = TextEditingController();
  final birthDateController = TextEditingController();
  bool isCash = true;

  @override
  Widget build(BuildContext context) {
    final vievmodel = ProfileViewmodel();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "account".tr(context: context),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),

        actions: [
          IconButton(
            onPressed: () async {
              final user = await vievmodel.getUser();

              nameController.text = user?.firstName ?? "";
              genderController.text = user?.gender ?? "";
              lastNameController.text = user?.lastName ?? "";
              birthDateController.text = user?.birthDate ?? "";

              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 10,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("edit".tr(context: context)),

                              Field(controller: nameController, label: "ism"),
                              Field(
                                controller: lastNameController,
                                label: "surname".tr(context: context),
                              ),
                              Field(
                                controller: genderController,
                                label: "gender".tr(context: context),
                              ),
                              Field(
                                controller: birthDateController,
                                label: "birth_day".tr(context: context),
                              ),
                              10.h,
                              ElevatedButton(
                                onPressed: () async {
                                  final updatedUser = user!.copyWith(
                                    firstName: nameController.text,
                                    lastName: lastNameController.text,
                                    gender: genderController.text,
                                    birthDate: birthDateController.text,
                                  );
                                  final success = await vievmodel.updateUser(
                                    updatedUser,
                                  );
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: Text("save".tr(context: context)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: FutureBuilder<ProfileModel?>(
        future: vievmodel.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print(snapshot.stackTrace);
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.data == null) {
            print(snapshot.data);
            return Center(child: Text('no_data'.tr(context: context)));
          }
          final user = snapshot.data!;
          // final bottomSize = MediaQuery.of(context).viewInsets.bottom + 20;

          return Container(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.person, size: 40),
                      ),
                      15.w,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${user.firstName}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "${user.lastName}",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),

                  15.h,
                  UserInformationColumn(
                    firstInfo: user.login,
                    secondInfo: "username".tr(context: context),
                  ),
                  15.h,
                  UserInformationColumn(
                    firstInfo: user.birthDate,
                    secondInfo: "birth_day".tr(context: context),
                  ),
                  15.h,
                  UserInformationColumn(
                    firstInfo: user.gender,
                    secondInfo: "gender".tr(context: context),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
