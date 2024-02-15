import 'package:e_form/config/app_route.dart';
import 'package:e_form/config/session.dart';
import 'package:e_form/controller/c_menubar.dart';
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

  void logout() {
    CMenuBar cMenuBar = Get.put(CMenuBar());
    cMenuBar.indexPage = 0;
    Session.clearUser();
    Get.toNamed(AppRoute.login);
  }
}
