import 'dart:convert';

import 'package:e_form/controller/c_auth.dart';
import 'package:e_form/models/user.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static Future<bool> saveUser(ResponseLogin responseLogin) async {
    final pref = await SharedPreferences.getInstance();
    Map<String, dynamic> mapLogin = responseLogin.toJson();
    String stringUser = jsonEncode(mapLogin);
    bool success = await pref.setString('auth', stringUser);

    if (success) {
      final cAuth = Get.put(CAuth());
      cAuth.setUser(mapLogin);
    }

    return success;
  }

  static Future<CAuth> getUser() async {
    final prefGet = await SharedPreferences.getInstance();
    String? stringUserGet = prefGet.getString('auth');
    final cAuth = Get.put(CAuth());

    if (stringUserGet != null) {
      Map<String, dynamic> mapUser = jsonDecode(stringUserGet);
      ResponseLogin responseLogin = ResponseLogin.fromJson(mapUser);
      Map<String, dynamic> responseLoginToJson = responseLogin.toJson();
      cAuth.setUser(responseLoginToJson);
    }
    return cAuth;
  }

  static Future<bool> clearUser() async {
    final pref = await SharedPreferences.getInstance();
    bool success = await pref.remove('auth');
    final cAuth = Get.put(CAuth());
    Map<dynamic, dynamic> userData = {"users": {}, "roles": {}, "token": ""};
    cAuth.setUser(userData);
    return success;
  }
}
