import 'dart:ui';

import 'package:e_form/config/app_color.dart';
import 'package:e_form/controller/c_auth.dart';
import 'package:get/get.dart';

class Helper {
  bool isApprove(Map<String, dynamic> receivedData) {
    CAuth cAuth = Get.put(CAuth());

    final roles = cAuth.authData.value.roles;
    final usersReview = receivedData['users_id_review'];
    final status = receivedData['status'];
    final isExpired = receivedData['is_expired'];
    final users = cAuth.authData.value.users;

    final idLogin = users['id'];
    var buttonReview = false;
    var buttonNext = false;
    if (status == 'menunggu') {
      buttonNext = true;
    }
    if (status == 'ditolak') {
      buttonNext = false;
    }
    if (status == 'disetujui') {
      buttonNext = false;
    }

    if (usersReview == idLogin && buttonNext) {
      buttonReview = true;
    }

    final isAdmin = roles['name'] == 'Admin';
    bool isApprove = (buttonReview || isAdmin) &&
            status != 'disetujui' &&
            status != 'ditolak' &&
            isExpired != true ||
        status == 'direvisi';

    return isApprove;
  }

  bool isConfirmedApprovel(Map<String, dynamic> receivedData) {
    final jabatan = receivedData['position'];
    final usersReview = receivedData['users_review'];
    final usersReviewJabatan = usersReview != null
        ? usersReview['profile']['jabatan']['nama_jabatan']
        : null;
    bool isConfirmed = jabatan == 'Direktur' ||
        jabatan == 'Direktur Jenderal' ||
        usersReviewJabatan == 'Direktur' ||
        usersReviewJabatan == 'Direktur Jenderal';
    return isConfirmed;
  }

  Color colorCard(Map<String, dynamic> receivedData) {
    if (receivedData['is_expired'] == true) {
      return AppColor.statusExpired;
    } else {
      switch (receivedData['status']) {
        case 'menunggu':
          return AppColor.statusMenunggu;
        case 'disetujui':
          return AppColor.statusDisetujui;
        case 'ditolak':
          return AppColor.statusDitolak;
        case 'direvisi':
          return AppColor.statusDirevisi;
        default:
          return AppColor.statusMenunggu;
      }
    }
  }
}
