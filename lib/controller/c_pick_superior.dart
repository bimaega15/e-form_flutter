// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:e_form/config/app_route.dart';
import 'package:e_form/config/utils.dart';
import 'package:e_form/controller/c_dashboard.dart';
import 'package:e_form/controller/c_transaksi.dart';
import 'package:e_form/source/FormTransaksi.dart';
import 'package:e_form/source/PickSuperiorSource.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' hide Response;

class PickSuperior {
  final int id;
  final String text;

  PickSuperior({
    required this.id,
    required this.text,
  });

  Map<String, dynamic> get toJson {
    return {
      "id": id,
      "text": text,
    };
  }
}

class CPickSuperior extends GetxController {
  List<dynamic> getSuperior = [].obs;
  Rx<int> page = 1.obs;
  Rx<bool> isFocused = false.obs;
  Rx<bool> isLoadingSubmit = false.obs;
  Rx<bool> isLoading = false.obs;
  Rx<String> searchText = ''.obs;
  Rx<bool> hasMoreData = true.obs;
  Rx<int> users_id_forward = 0.obs;
  Rx<String> keterangan_approvel = ''.obs;
  void setKeteranganApprovel(String value) => keterangan_approvel.value = value;
  final RxMap<String, String> errorMessages = <String, String>{}.obs;

  TextEditingController forwardUsers = TextEditingController();

  void getUsersProfile(
      {String search = '', int transactionId = 0, onSearch = false}) async {
    try {
      isLoading.value = true;
      Response response = await PickSuperiorSource.getUsersProfile(
          page.value, transactionId, search);
      if (response.statusCode == 200) {
        var res = response.data;
        Map<String, dynamic> result = res['result'];
        if (result['count_filtered'] > 0) {
          List<dynamic> results = result['results'];
          if ((search != '' && search.isNotEmpty && onSearch) ||
              (search == '' && onSearch)) {
            getSuperior.clear();
          }

          if (!(page.value == 1 &&
              getSuperior.isNotEmpty &&
              search != '' &&
              search.isNotEmpty)) {
            for (var element in results) {
              getSuperior.add(
                  PickSuperior(id: element['id'], text: element['text'])
                      .toJson);
            }
            page.value = page.value + 1;
            Response response = await PickSuperiorSource.getUsersProfile(
                page.value, transactionId, search);
            hasMoreData(true);
            if (response.statusCode == 200) {
              var res = response.data;
              Map<String, dynamic> result = res['result'];
              if (result['count_filtered'] == 0) {
                hasMoreData(false);
              }
            }
          }
        } else {
          if (search != '' && search.isNotEmpty && onSearch) {
            getSuperior.clear();
          }
          hasMoreData(false);
        }
      } else {
        print(response.statusMessage);
        // Utils().showSnackbar('error', 'Failed', response.statusMessage);
      }
      isLoading.value = false;
    } catch (e) {
      print(e);
      // Utils().showSnackbar('error', 'Failed', 'Terjadi kesalahan');
    }

    update();
  }

  void resetUsersProfile() {
    getSuperior.clear();
    page.value = 1;
  }

  void setFocused(bool focused, int transactionId) {
    isFocused.value = focused;
    if (focused) {
      getUsersProfile(
          onSearch: false,
          transactionId: transactionId,
          search: searchText.value);
    } else {
      resetUsersProfile();
    }
    update();
  }

  void searchUsersProfile(String search, int transactionId) {
    searchText.value = search;
    page.value = 1;
    getUsersProfile(
        onSearch: true, transactionId: transactionId, search: search);
    update();
  }

  void pickSuperior(dataSuperior) {
    forwardUsers.text = dataSuperior['text'];
    users_id_forward.value = dataSuperior['id'];
    setFocused(false, dataSuperior['id']);
    update();
  }

  void resetForm() {
    getSuperior.clear();
    page.value = 1;
    isFocused.value = false;
    isLoading.value = false;
    searchText.value = '';
    hasMoreData.value = true;
    users_id_forward.value = 0;
    keterangan_approvel.value = '';
    forwardUsers.text = '';
    errorMessages.value = {};
    isLoadingSubmit.value = false;
  }

  void addError(String field, String message) {
    errorMessages[field] = message;
  }

  void clearError(String field) {
    errorMessages.remove(field);
  }

  void resetFormAttribute() {
    clearError('users_id_forward');
    clearError('keterangan_approvel');
  }

  bool hasErros() {
    bool isError = false;
    resetFormAttribute();

    if (users_id_forward.value == 0) {
      isError = true;
      addError('users_id_forward', 'Atasan wajib dipilih');
    }

    if (keterangan_approvel.value.isEmpty) {
      isError = true;
      addError('keterangan_approvel', 'Keterangan wajib diisi');
    }

    return isError;
  }

  bool hasErrorFinish() {
    bool isError = false;
    resetFormAttribute();

    if (keterangan_approvel.value.isEmpty) {
      isError = true;
      addError('keterangan_approvel', 'Keterangan wajib diisi');
    }

    return isError;
  }

  void submitData(int transactionId) async {
    CTransaksi cTransaksi = Get.put(CTransaksi());
    CDashboard cDashboard = Get.put(CDashboard());

    try {
      isLoadingSubmit.value = true;
      var data = {
        'transaction_id': transactionId,
        'users_id_forward': users_id_forward.value,
        'keterangan_approvel': keterangan_approvel.value,
      };

      Response response = await FormTransaksiSource.forwardTransaction(data);
      if (response.statusCode == 201) {
        var result = response.data;
        Utils().showSnackbar('success', 'Success', result['message']);
        cTransaksi.resetData();
        cDashboard.resetData();
        await Future.delayed(const Duration(seconds: 1));

        Get.offAllNamed(AppRoute.home);
      } else {
        Utils()
            .showSnackbar('error', response.statusCode, response.statusMessage);
      }
      isLoadingSubmit.value = false;
    } catch (e) {
      print(e);
      // Utils().showSnackbar('error', 'Failed', 'Terjadi kesalahan');
    }
  }

  void finishData(Map<dynamic, dynamic> data) async {
    CTransaksi cTransaksi = Get.put(CTransaksi());
    CDashboard cDashboard = Get.put(CDashboard());

    try {
      isLoadingSubmit.value = true;
      Response response = await FormTransaksiSource.finishTransaction(data);
      if (response.statusCode == 200) {
        var result = response.data;
        Utils().showSnackbar('success', 'Success', result['message']);
        cTransaksi.resetData();
        cDashboard.resetData();
        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(AppRoute.home);
      } else {
        Utils()
            .showSnackbar('error', response.statusCode, response.statusMessage);
      }
      isLoadingSubmit.value = false;
    } catch (e) {
      print(e);
      // Utils().showSnackbar('error', 'Failed', 'Terjadi kesalahan');
    }

    update();
  }
}
