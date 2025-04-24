import 'bookings_model.dart';

class ProfileModel {
  final String birthDate;
  final Map<String, BookingsModel> bookings;
  final String firstName;
  final String lastName;
  final String gender;
  final String login;
  final String password;

  ProfileModel({
    required this.birthDate,
    required this.bookings,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.login,
    required this.password,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      birthDate: map['birthDate'] ?? '',
      bookings: (map['bookings'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, BookingsModel.fromMap(value)),
      ),
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      gender: map['gender'] ?? '',
      login: map['login'] ?? '',
      password: map['password'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'birthDate': birthDate,
      'bookings': bookings.map((key, value) => MapEntry(key, value.toMap())),
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'login': login,
      'password': password,
    };
  }

  ProfileModel copyWith({
    String? birthDate,
    Map<String, BookingsModel>? bookings,
    String? firstName,
    String? lastName,
    String? gender,
    String? login,
    String? password,
  }) {
    return ProfileModel(
      birthDate: birthDate ?? this.birthDate,
      bookings: bookings ?? this.bookings,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      login: login ?? this.login,
      password: password ?? this.password,
    );
  }
}
