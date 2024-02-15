import 'package:dio/dio.dart';
import 'package:e_form/config/app_route.dart';
import 'package:e_form/config/utils.dart';
import 'package:e_form/controller/c_profile.dart';
import 'package:e_form/source/ProfileSource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

class CEditProfile extends GetxController {
  Rx<String> nik_profile = ''.obs;
  void setNikProfile(String value) => nik_profile.value = value;
  TextEditingController nik_profile_controller = TextEditingController();
  Rx<String> nama_profile = ''.obs;
  void setNamaProfile(String value) => nama_profile.value = value;
  TextEditingController nama_profile_controller = TextEditingController();

  Rx<String> email_profile = ''.obs;
  void setEmailProfile(String value) => email_profile.value = value;
  TextEditingController email_profile_controller = TextEditingController();

  Rx<String> nohp_profile = ''.obs;
  void setNoHpProfile(String value) => nohp_profile.value = value;
  TextEditingController nohp_profile_controller = TextEditingController();

  Rx<String> jeniskelamin_profile = 'L'.obs;
  void setJenisKelaminProfile(value) => jeniskelamin_profile.value = value;

  Rx<String> alamat_profile = ''.obs;
  void setAlamatProfile(String value) => alamat_profile.value = value;
  TextEditingController alamat_profile_controller = TextEditingController();

  final RxMap<String, String> errorMessages = <String, String>{}.obs;
  Rx<bool> isLoading = false.obs;

  void addError(String field, String message) {
    errorMessages[field] = message;
  }

  void clearError(field) {
    errorMessages.remove(field);
  }

  void submitForm(int id) async {
    CProfile cProfile = Get.put(CProfile());
    try {
      isLoading.value = true;
      Map<dynamic, dynamic> data = {
        'nik_profile': nik_profile.value,
        'nama_profile': nama_profile.value,
        'email_profile': email_profile.value,
        'nohp_profile': nohp_profile.value,
        'jeniskelamin_profile': jeniskelamin_profile.value,
        'alamat_profile': alamat_profile.value,
      };
      Response response = await ProfileSource.editProfile(id, data);
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
    nik_profile.value = '';
    nik_profile_controller.text = '';
    nama_profile.value = '';
    nama_profile_controller.text = '';
    email_profile.value = '';
    email_profile_controller.text = '';
    nohp_profile.value = '';
    nohp_profile_controller.text = '';
    jeniskelamin_profile.value = '';
    alamat_profile.value = '';
    alamat_profile_controller.text = '';
    errorMessages.value = {};
    isLoading.value = false;
  }
}
