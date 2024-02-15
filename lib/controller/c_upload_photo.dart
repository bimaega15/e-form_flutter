import 'package:e_form/config/app_route.dart';
import 'package:e_form/config/utils.dart';
import 'package:e_form/controller/c_profile.dart';
import 'package:e_form/source/ProfileSource.dart';
import 'package:get/get.dart' hide Response;

import 'dart:io';
import 'package:dio/dio.dart';

class CUploadPhoto extends GetxController {
  File gambar_profile = File('');
  void setGambarProfile(File value) {
    gambar_profile = value;
    update();
  }

  final RxMap<String, String> errorMessages = <String, String>{}.obs;
  Rx<bool> isLoading = false.obs;

  void addError(String field, String message) {
    errorMessages[field] = message;
  }

  void clearError(field) {
    errorMessages.remove(field);
  }

  void submitForm(int id, data) async {
    CProfile cProfile = Get.put(CProfile());
    try {
      isLoading.value = true;

      Response response = await ProfileSource.uploadPhoto(id, data);

      if (response.statusCode == 200) {
        var result = response.data;
        Utils().showSnackbar('success', 'Success', result['message']);
        await Future.delayed(const Duration(seconds: 1));
        cProfile.resetMyProfile();
        Get.offAllNamed(AppRoute.home);
      } else if (response.statusCode == 400) {
        var responseResult = response.data;
        Map<dynamic, dynamic> results = responseResult['result'];
        var entriesError = errorMessages.entries.toList();
        entriesError.forEach((element) {
          clearError(element.key);
        });
        results.forEach((key, value) {
          var message = results[key][0];
          addError(key, message);
        });
      } else {
        Utils()
            .showSnackbar('error', response.statusCode, response.statusMessage);
      }
      isLoading.value = false;
    } catch (e) {
      print(e);
      // Utils().showSnackbar('error', 'Failed', 'Terjadi kesalahan');
    }

    update();
  }

  void resetForm() {
    gambar_profile = File('');
  }
}
