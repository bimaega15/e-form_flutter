import 'package:get/get.dart';

class AuthData {
  Map<dynamic, dynamic> users;
  Map<dynamic, dynamic> roles;
  String token;

  AuthData({required this.users, required this.roles, required this.token});

  Map<dynamic, dynamic> get toJson {
    return {
      "users": users,
      "roles": roles,
      "token": token,
    };
  }
}

class CAuth extends GetxController {
  Rx<AuthData> authData = AuthData(users: {}, roles: {}, token: '').obs;

  void setUser(Map<dynamic, dynamic> userData) {
    AuthData data = AuthData(
      users: userData['users'],
      roles: userData['roles'],
      token: userData['token'],
    );
    authData.value = data;
  }
}
