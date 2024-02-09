// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:e_form/config/app_route.dart';
import 'package:e_form/config/utils.dart';
import 'package:e_form/controller/c_list_product.dart';
import 'package:e_form/controller/c_overbooking.dart';
import 'package:e_form/source/FormTransaksi.dart';
import 'package:get/get.dart' hide Response;

class CFormTransaksi extends GetxController {
  CListProduct cListProduct = Get.put(CListProduct());
  COverBooking cOverBooking = Get.put(COverBooking());

  Rx<String> code_transaction = ''.obs;
  void setCodeTransaction(String value) => code_transaction.value = value;

  Rx<String> tanggal_transaction = DateTime.now().toString().split(' ')[0].obs;
  void setTanggalTransaction(value) {
    tanggal_transaction.value = value.toString().split(' ')[0];
    update();
  }

  Rx<String> paidto_transaction = ''.obs;
  void setPaidToTransaction(String value) => paidto_transaction.value = value;

  Rx<String> metode_pembayaran_id = ''.obs;
  void setMetodePembayaranId(String? value) {
    metode_pembayaran_id.value = value!;
    update();
  }

  Rx<int> paymentterms_transaction = 0.obs;
  void setPaymentTermsTransaction(int value) =>
      paymentterms_transaction.value = value;

  Rx<String> expired_transaction = DateTime.now().toString().split(' ')[0].obs;
  void setExpiredTransaction(value) {
    expired_transaction.value = value.toString().split(' ')[0];
    update();
  }

  Rx<String> purpose_transaction = ''.obs;
  void setPuposeTransaction(String value) => purpose_transaction.value = value;

  Rx<int> totalproduct_transaction = 0.obs;
  void setTotalProductTransaction(int value) =>
      totalproduct_transaction.value = value;

  Rx<num> totalprice_transaction = 0.obs;
  void setTotalPriceTransaction(num value) =>
      totalprice_transaction.value = value;

  Rx<String> purposedivisi_transaction = ''.obs;
  void setPurposeDivisiTransaction(String value) =>
      purposedivisi_transaction.value = value;

  Rx<bool?> isppn_transaction = false.obs;
  void setIsPpnTransaction(bool? value) {
    isppn_transaction.value = value;
    if (value == false) {
      valueppn_transaction.value = 0;
    }
    update();
  }

  Rx<num> valueppn_transaction = 0.obs;
  void setValuePpnTransaction(num value) => valueppn_transaction.value = value;

  File attachment_transaction = File('');
  void setAttachmentTransaction(File value) {
    attachment_transaction = value;
    update();
  }

  Rx<bool?> overbooking_transaction = false.obs;
  void setOverbookingTransaction(bool? value) {
    overbooking_transaction.value = value;
    update();
  }

  RxMap metodePembayaranList = {}.obs;
  Rx<bool> isLoadingMetodePembayaranList = true.obs;

  Rx<String> nomorvirtual_transaction = ''.obs;
  void setNomorVirtualTransaction(String value) =>
      nomorvirtual_transaction.value = value;

  Rx<String> accept_transaction = ''.obs;
  void setAcceptTransaction(String value) => accept_transaction.value = value;

  Rx<String> bank_transaction = ''.obs;
  void setBankTransaction(String value) => bank_transaction.value = value;

  void getStaticData() async {
    final response = await FormTransaksiSource.dataStatic();
    isLoadingMetodePembayaranList.value = false;
    metodePembayaranList.value = response['result'];
    List<dynamic> defaultValuePembayaranList =
        response['result']['metodePembayaran'];
    metode_pembayaran_id.value =
        defaultValuePembayaranList.first['id'].toString();
    update();
  }

  Rx<bool> isLoadingSubmit = false.obs;
  Rx<bool> isRefreshData = false.obs;
  void setIsRefreshData(bool value) => isRefreshData.value = value;

  final RxMap<String, String> errorMessages = <String, String>{}.obs;

  void addError(String field, String message) {
    errorMessages[field] = message;
  }

  void clearError(String field) {
    errorMessages.remove(field);
  }

  void resetFormAttribute() {
    clearError('code_transaction');
    clearError('tanggal_transaction');
    clearError('metode_pembayaran_id');
    clearError('expired_transaction');
    clearError('purpose_transaction');
    clearError('jenis_over_booking');
    clearError('darirekening_booking');
    clearError('pemilikrekening_booking');
    clearError('tujuanrekening_booking');
    clearError('pemiliktujuan_booking');
    clearError('nominal_booking');
  }

  bool hasErros() {
    bool isError = false;
    resetFormAttribute();

    if (code_transaction.value.isEmpty) {
      isError = true;
      addError('code_transaction', 'Kode transaksi tidak boleh kosong');
    }

    if (tanggal_transaction.value.isEmpty) {
      isError = true;
      addError('tanggal_transaction', 'Tanggal transaksi tidak boleh kosong');
    }

    if (metode_pembayaran_id.value.isEmpty) {
      isError = true;
      addError('metode_pembayaran_id', 'Metode pembayaran tidak boleh kosong');
    }

    if (expired_transaction.value.isEmpty) {
      isError = true;
      addError('expired_transaction', 'Tanggal expired tidak boleh kosong');
    }

    if (purpose_transaction.value.isEmpty) {
      isError = true;
      addError('purpose_transaction', 'Tujuan transaksi tidak boleh kosong');
    }

    if (overbooking_transaction.value == true) {
      if (cOverBooking.jenis_over_booking.isEmpty) {
        isError = true;
        addError('jenis_over_booking', 'Jenis overbooking tidak boleh kosong');
      }

      if (cOverBooking.darirekening_booking.isEmpty) {
        isError = true;
        addError('darirekening_booking', 'Dari rekening tidak boleh kosong');
      }

      if (cOverBooking.pemilikrekening_booking.isEmpty) {
        isError = true;
        addError(
            'pemilikrekening_booking', 'Pemilik rekening tidak boleh kosong');
      }

      if (cOverBooking.tujuanrekening_booking.isEmpty) {
        isError = true;
        addError(
            'tujuanrekening_booking', 'Tujuan rekening tidak boleh kosong');
      }

      if (cOverBooking.pemiliktujuan_booking.isEmpty) {
        isError = true;
        addError('pemiliktujuan_booking',
            'Pemilik tujuan rekening tidak boleh kosong');
      }

      if (cOverBooking.nominal_booking.isEmpty) {
        isError = true;
        addError('nominal_booking', 'Nominal booking tidak boleh kosong');
      }
    }

    return isError;
  }

  Future<void> postTransaksi(dynamic data) async {
    try {
      if (hasErros()) {
        Utils().showSnackbar(
            'error', 'Faiiled', 'Periksa kembali form inputan anda');
      } else {
        isLoadingSubmit.value = true;

        var response = await FormTransaksiSource.postTransaksi(data);
        isLoadingSubmit.value = false;
        update();

        if (response['status'] == 400) {
          Utils().showSnackbar('error', 'Failed', response['message']);
        } else {
          Utils().showSnackbar(
              'success', 'Success', 'Berhasil menambahkan transaksi');
          await Future.delayed(const Duration(seconds: 1));
          isRefreshData.value = true;
          Get.offAllNamed(AppRoute.home);
        }
      }
    } catch (e) {
      print(e);
      isLoadingSubmit.value = false;
      Utils().showSnackbar('error', 'Failed', 'Terjadi kesalahan');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getStaticData();
  }

  void resetForm() {
    code_transaction.value = '';
    tanggal_transaction.value = DateTime.now().toString().split(' ')[0];
    paidto_transaction.value = '';
    metode_pembayaran_id.value = '';
    paymentterms_transaction.value = 0;
    expired_transaction.value = DateTime.now().toString().split(' ')[0];
    purpose_transaction.value = '';
    totalproduct_transaction.value = 0;
    totalprice_transaction.value = 0;
    purposedivisi_transaction.value = '';
    isppn_transaction.value = false;
    valueppn_transaction.value = 0;
    attachment_transaction = File('');
    overbooking_transaction.value = false;
    metodePembayaranList = {}.obs;
    isLoadingMetodePembayaranList.value = true;
    nomorvirtual_transaction.value = '';
    accept_transaction.value = '';
    bank_transaction.value = '';
    isLoadingSubmit.value = false;
    getStaticData();
    update();
  }
}
