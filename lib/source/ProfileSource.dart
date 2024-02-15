// ignore_for_file: unnecessary_new, avoid_print, file_names
import 'package:dio/dio.dart';
import 'package:e_form/config/api_service.dart';

class ProfileSource {
  static Future myProfile() async {
    try {
      Response myProfile = await ApiService().get('/profile');
      return myProfile.data;
    } catch (e) {
      print(e);
    }
  }

  static Future changePassword(int id, Map<dynamic, dynamic> data) async {
    try {
      Response myProfile = await ApiService()
          .post('/profile/$id/updatePassword?_method=put', data);
      return myProfile;
    } catch (e) {
      print(e);
    }
  }

  static Future editProfile(int id, Map<dynamic, dynamic> data) async {
    try {
      Response myProfile =
          await ApiService().post('/profile/$id?_method=put', data);
      return myProfile;
    } catch (e) {
      print(e);
    }
  }

  static Future uploadPhoto(int id, data) async {
    try {
      Response myProfile =
          await ApiService().post('/profile/$id/updateImage?_method=put', data);
      return myProfile;
    } catch (e) {
      print(e);
    }
  }
}
