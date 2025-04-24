import 'dart:convert';
import "package:http/http.dart" as http;
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
}
