import 'package:hotel_app/features/auth/data/models/auth_model.dart';

class AuthViewmodel {
  AuthViewmodel._konstruktor();
  static final AuthViewmodel object = AuthViewmodel._konstruktor();
  factory AuthViewmodel() {
    return object;
  }

  AuthModel? userAuthModel;

  void userInit(AuthModel user) async {
    userAuthModel = user;
  }
}
