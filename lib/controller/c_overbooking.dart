// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart' hide Response;

class COverBooking extends GetxController {
  Rx<String> jenis_over_booking = 'Rekening ke Rekening'.obs;
  void setJenisOverBooking(String? value) => jenis_over_booking.value = value!;

  Rx<String> darirekening_booking = ''.obs;
  void setDariRekeningBooking(String value) =>
      darirekening_booking.value = value;

  Rx<String> pemilikrekening_booking = ''.obs;
  void setPemilikRekening(String value) =>
      pemilikrekening_booking.value = value;

  Rx<String> tujuanrekening_booking = ''.obs;
  void setTujuanRekening(String value) => tujuanrekening_booking.value = value;

  Rx<String> pemiliktujuan_booking = ''.obs;
  void setPemilikTujuan(String value) => pemiliktujuan_booking.value = value;

  Rx<String> nominal_booking = ''.obs;
  void setNominalBooking(String value) {
    nominal_booking.value = value.replaceAll(',', '');
    update();
  }

  void resetForm() {
    jenis_over_booking = 'Rekening ke Rekening'.obs;
    darirekening_booking.value = '';
    pemilikrekening_booking.value = '';
    tujuanrekening_booking.value = '';
    pemiliktujuan_booking.value = '';
    nominal_booking.value = '';
    update();
  }
}
