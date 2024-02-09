// ignore_for_file: unnecessary_new
import 'package:dio/dio.dart';
import 'package:e_form/config/api_service.dart';
import 'package:e_form/config/utils.dart';

class ProfileSource {
  static Future<Map<String, dynamic>> myProfile() async {
    try {
      Response myProfile = await ApiService().get('/profile');
      return myProfile.data;
    } catch (e) {
      Utils().printError(e);
      return {};
    }
  }
}
