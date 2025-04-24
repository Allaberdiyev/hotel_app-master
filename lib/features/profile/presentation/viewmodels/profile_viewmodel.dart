import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/profile_model.dart';

class ProfileViewmodel {
  Future<ProfileModel?> getUser() async {
    ProfileModel? user;
    final uri = Uri.parse(
      "https://e-commerce-d13dc-default-rtdb.firebaseio.com/hotel/users/user2.json",
    );

    try {
      final response = await http.get(uri);
      final decoded = jsonDecode(response.body);

      if (decoded is Map<String, dynamic>) {
        user = ProfileModel.fromMap(decoded);
      } else {
        print("⚠️ Not a valid user data: $decoded");
      }
    } catch (e, c) {
      print(e);
      print(c);
    }

    return user;
  }

  Future<void> updateUser(ProfileModel updatedUser) async {
    final uri = Uri.parse(
      "https://e-commerce-d13dc-default-rtdb.firebaseio.com/hotel/users/user2.json",
    );

    final response = await http.patch(
      uri,
      body: jsonEncode(updatedUser.toMap()),
    );
  }

  Future<void> saveUserLogin(String login) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_login', login);
  }
}
