// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:e_form/config/app_route.dart';
import 'package:e_form/config/utils.dart';
import 'package:e_form/source/ProfileSource.dart';
import 'package:get/get.dart' hide Response;

class CChangePassword extends GetxController {
  Rx<String> passwordLama = ''.obs;
  void setPasswordLama(String value) => passwordLama.value = value;
  Rx<String> passwordBaru = ''.obs;
  void setPasswordBaru(String value) => passwordBaru.value = value;
  Rx<String> konfirmasiPasswordBaru = ''.obs;
  void setKonfirmasiPasswordBaru(String value) =>
      konfirmasiPasswordBaru.value = value;
  final RxMap<String, String> errorMessages = <String, String>{}.obs;
  Rx<bool> isLoading = false.obs;

  void addError(String field, String message) {
    errorMessages[field] = message;
  }

  void clearError(String field) {
    errorMessages.remove(field);
  }

  void resetErrors() {
    clearError('password_lama');
    clearError('password_baru');
    clearError('konfirmasi_password_baru');
  }

  bool hasErrors() {
    resetErrors();
    bool isError = false;
    if (passwordLama.value == '') {
      isError = true;
      addError('password_lama', 'Password lama wajib diisi');
    }
    if (passwordBaru.value == '') {
      isError = true;
      addError('password_baru', 'Password baru wajib diisi');
    }
    if (konfirmasiPasswordBaru.value == '') {
      isError = true;
      addError('konfirmasi_password_baru', 'Konfirmasi password wajib diisi');
    }
    return isError;
  }

  void submitForm(int id) async {
    try {
      isLoading.value = true;
      Map<dynamic, dynamic> data = {
        'password': passwordBaru.value,
        'password_confirm': konfirmasiPasswordBaru.value,
        'password_old': passwordLama.value,
      };
      Response response = await ProfileSource.changePassword(id, data);
      if (response.statusCode == 200) {
        var result = response.data;
        Utils().showSnackbar('success', 'Success', result['message']);
        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(AppRoute.home);
      } else if (response.statusCode == 400) {
        var responseResult = response.data;
        Map<dynamic, dynamic> results = responseResult['result'];
        results.forEach((key, value) {
          var result = results[key];
          if (key == 'password_old') {
            addError('password_lama', result[0]);
          }
          if (key == 'password') {
            addError('password_baru', result[0]);
          }
          if (key == 'password_confirm') {
            addError('konfirmasi_password_baru', result[0]);
          }
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

  void resetFormAttribute() {
    clearError('passwordLama');
    clearError('passwordBaru');
    clearError('konfirmasiPasswordBaru');
  }

  void resetForm() {
    passwordLama.value = '';
    passwordBaru.value = '';
    konfirmasiPasswordBaru.value = '';
    errorMessages.value = {};
    isLoading.value = false;
  }
}
