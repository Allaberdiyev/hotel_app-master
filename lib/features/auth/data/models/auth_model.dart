class AuthModel {
  String? id;
  final String login;
  final String password;
  final String birthDate;
  final String firstName;
  final String lastName;
  final String gender;
  // final List<String> booking;

  AuthModel({
    required this.login,
    required this.password,
    this.id = '',
    this.birthDate = '',
    this.firstName = '',
    this.lastName = '',
    this.gender = '',
  });
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json["id"],
      login: json['login'].toString(),
      password: json['password'].toString(),
      birthDate: json['birthDate'].toString(),
      firstName: json['firstName'].toString(),
      lastName: json['lastName'].toString(),
      gender: json['gender'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'login': login,
      'password': password,
      'birthDate': birthDate,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
    };
  }
}
