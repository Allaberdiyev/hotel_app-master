import 'dart:convert';
import 'package:hotel_app/features/auth/data/models/auth_model.dart';
import 'package:hotel_app/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSources {
  final authViewModel = AuthViewmodel();
  final String url =
      'https://e-commerce-d13dc-default-rtdb.firebaseio.com/hotel/users.json';

  Future<List<AuthModel>> getAllUsers() async {
    final res = await http.get(Uri.parse(url));
    final data = json.decode(res.body) as Map<String, dynamic>;

    return data.entries.map((e) {
      final data = e.value;
      data["id"] = e.key;
      return AuthModel.fromJson(data);
    }).toList();
  }

  Future<void> addUser(AuthModel user) async {
    final response = await http.post(
      Uri.parse(url),
      body: json.encode(user.toJson()),
    );
  }

  Future<List<AuthModel>> fetchUsers() async {
    final response = await http.get(Uri.parse(url));

    final Map<String, dynamic> data = json.decode(response.body);

    final result =
        data.entries.map((e) {
          final json = e.value;

          json["id"] = e.key;

          return AuthModel.fromJson(json);
        }).toList();

    return result;
  }

  Future<void> updatePassword(String login, String newPassword) async {
    final users = await fetchUsers();

    final entry = users.firstWhere((e) => e.login == login);

    final patchUrl =
        'https://e-commerce-d13dc-default-rtdb.firebaseio.com/hotel/users/${entry.id}.json';

    await http.patch(
      Uri.parse(patchUrl),
      body: json.encode({'password': newPassword}),
    );
  }

  Future<bool> updateUserInfos(AuthModel user) async {
    final users = await fetchUsers();

    final entry = users.firstWhere((e) => e.login == user.login);

    if (entry.id!.isEmpty) return false;

    final url =
        'https://e-commerce-d13dc-default-rtdb.firebaseio.com/hotel/users/${entry.id}.json';

    final response = await http.patch(
      Uri.parse(url),
      body: json.encode({
        'firstName': user.firstName,
        'lastName': user.lastName,
        'birthDate': user.birthDate,
        'gender': user.gender,
      }),
    );

    return response.statusCode == 200;
  }
}
