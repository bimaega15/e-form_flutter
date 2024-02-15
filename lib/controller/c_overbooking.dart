// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

class COverBooking extends GetxController {
  Rx<String> jenis_over_booking = 'Rekening ke Rekening'.obs;
  void setJenisOverBooking(String? value) {
    jenis_over_booking.value = value!;
  }

  Rx<String> darirekening_booking = ''.obs;
  TextEditingController darirekening_booking_controller =
      TextEditingController();
  void setDariRekeningBooking(String value) {
    darirekening_booking.value = value;
    darirekening_booking_controller.text = value;
  }

  Rx<String> pemilikrekening_booking = ''.obs;
  TextEditingController pemilikrekening_booking_controller =
      TextEditingController();
  void setPemilikRekening(String value) {
    pemilikrekening_booking.value = value;
    pemilikrekening_booking_controller.text = value;
  }

  Rx<String> tujuanrekening_booking = ''.obs;
  TextEditingController tujuanrekening_booking_controller =
      TextEditingController();
  void setTujuanRekening(String value) {
    tujuanrekening_booking.value = value;
    tujuanrekening_booking_controller.text = value;
  }

  Rx<String> pemiliktujuan_booking = ''.obs;
  TextEditingController pemiliktujuan_booking_controller =
      TextEditingController();
  void setPemilikTujuan(String value) {
    pemiliktujuan_booking.value = value;
    pemiliktujuan_booking_controller.text = value;
  }

  Rx<String> nominal_booking = ''.obs;
  TextEditingController nominal_booking_controller = TextEditingController();
  void setNominalBooking(String value, {bool edit = false}) {
    nominal_booking.value = value.replaceAll(',', '');
    if (edit) {
      nominal_booking_controller.text = value;
    }
    update();
  }

  void resetForm() {
    jenis_over_booking = 'Rekening ke Rekening'.obs;
    darirekening_booking.value = '';
    darirekening_booking_controller.text = '';
    pemilikrekening_booking.value = '';
    pemilikrekening_booking_controller.text = '';
    tujuanrekening_booking.value = '';
    tujuanrekening_booking_controller.text = '';
    pemiliktujuan_booking.value = '';
    pemiliktujuan_booking_controller.text = '';
    nominal_booking.value = '';
    nominal_booking_controller.text = '';
    update();
  }
}
