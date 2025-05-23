import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/features/profile/presentation/extension/space_extension.dart';
import 'package:hotel_app/features/profile/presentation/views/screens/profile_screen.dart';
import 'package:hotel_app/features/profile/presentation/views/screens/splash_screen.dart';
import '../../../data/models/profile_model.dart';
import '../../viewmodels/profile_viewmodel.dart';
import '../widgets/tile.dart';
import 'bookins_list.dart';

class Screen extends StatelessWidget {
  const Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = ProfileViewmodel();
    bool isCash = false;

    return FutureBuilder<ProfileModel?>(
      future: viewmodel.getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Scaffold(
            body: Center(child: Text("user_not_found".tr(context: context))),
          );
        }

        final user = snapshot.data!;

        return Scaffold(
          appBar: AppBar(title: Text("home".tr(context: context))),
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(child: Icon(Icons.person), radius: 30),
                          15.h,
                          Text(user.firstName),
                          Text(user.login),
                        ],
                      ),
                      // IconButton(
                      //   onPressed: () {
                      //     if (AdaptiveTheme.of(context).mode ==
                      //         AdaptiveThemeMode.light) {
                      //       AdaptiveTheme.of(context).setDark();
                      //     } else {
                      //       AdaptiveTheme.of(context).setLight();
                      //     }
                      //   },
                      //   icon: Icon(
                      //     AdaptiveTheme.of(context).mode ==
                      //             AdaptiveThemeMode.light
                      //         ? Icons.dark_mode
                      //         : Icons.light_mode,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Tile(
                  ikon: Icon(Icons.person),
                  subtitle: "view_and_edit_personal_info".tr(context: context),
                  title: "account_settings".tr(context: context),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                ),
                Tile(
                  ikon: Icon(Icons.history),
                  subtitle: "currently_booked_hotels".tr(context: context),
                  title: "hotel_history".tr(context: context),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return BookinsList(
                            bookings: user.bookings,
                          ); // Agar bookings mavjud bo‘lsa
                        },
                      ),
                    );
                  },
                ),

                Tile(
                  ikon: Icon(Icons.wallet),
                  subtitle: "manage_payment_methods".tr(context: context),
                  title: "management".tr(context: context),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setModalState) {
                            return Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("payment_method".tr(context: context)),
                                  ListTile(
                                    leading: Icon(Icons.money),

                                    title: Text(
                                      "pay_in_cash".tr(context: context),
                                    ),
                                    trailing:
                                        isCash
                                            ? Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            )
                                            : null,

                                    onTap: () {
                                      setModalState(() {
                                        isCash = true;
                                      });
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.credit_card),
                                    title: Text(
                                      "pay_by_card".tr(context: context),
                                    ),
                                    trailing:
                                        !isCash
                                            ? Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            )
                                            : null,
                                    onTap: () {
                                      setModalState(() {
                                        isCash = false;
                                      });
                                    },
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("save".tr(context: context)),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                Tile(
                  ikon: Icon(Icons.logout),
                  subtitle: "delete_account_and_return_to_home".tr(
                    context: context,
                  ),
                  title: "delete_account".tr(context: context),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) {
                          return SplashScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
