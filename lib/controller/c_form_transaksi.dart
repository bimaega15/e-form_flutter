// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_form/config/app_route.dart';
import 'package:e_form/config/number_text_formatter.dart';
import 'package:e_form/config/utils.dart';
import 'package:e_form/controller/c_dashboard.dart';
import 'package:e_form/controller/c_list_product.dart';
import 'package:e_form/controller/c_overbooking.dart';
import 'package:e_form/controller/c_transaksi.dart';
import 'package:e_form/source/FormTransaksi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

class CFormTransaksi extends GetxController {
  CListProduct cListProduct = Get.put(CListProduct());
  COverBooking cOverBooking = Get.put(COverBooking());

  Rx<bool> is_edit = false.obs;
  Rx<int> transaction_id = 0.obs;
  Rx<String> code_transaction = ''.obs;
  TextEditingController code_transaction_controller = TextEditingController();

  void setCodeTransaction(String value) {
    code_transaction.value = value;
    code_transaction_controller.text = value;
  }

  Rx<String> tanggal_transaction = DateTime.now().toString().split(' ')[0].obs;
  TextEditingController tanggal_transaction_controller = TextEditingController(
      text: Utils()
          .formatDateIndo(DateTime.now().toString().split(' ')[0].toString()));

  void setTanggalTransaction(value, {bool edit = false}) {
    tanggal_transaction.value = value.toString().split(' ')[0];
    if (edit) {
      tanggal_transaction_controller.text =
          Utils().formatDateIndo(value.toString().split(' ')[0]);
    } else {
      tanggal_transaction_controller.text =
          Utils().formatDateIndo(value.toString().split(' ')[0]);
    }
    update();
  }

  Rx<String> paidto_transaction = ''.obs;
  TextEditingController paidto_transaction_controller = TextEditingController();
  void setPaidToTransaction(String value) {
    paidto_transaction.value = value;
    paidto_transaction_controller.text = value;
  }

  Rx<String> metode_pembayaran_id = ''.obs;
  void setMetodePembayaranId(String? value) {
    metode_pembayaran_id.value = value!;
    update();
  }

  Rx<int> paymentterms_transaction = 0.obs;
  void setPaymentTermsTransaction(int value) =>
      paymentterms_transaction.value = value;

  Rx<String> expired_transaction = DateTime.now().toString().split(' ')[0].obs;
  TextEditingController expired_transaction_controller = TextEditingController(
      text: Utils()
          .formatDateIndo(DateTime.now().toString().split(' ')[0].toString()));
  void setExpiredTransaction(value, {bool edit = false}) {
    expired_transaction.value = value.toString().split(' ')[0];
    if (edit) {
      expired_transaction_controller.text =
          Utils().formatDateIndo(value.toString().split(' ')[0]);
    } else {
      expired_transaction_controller.text =
          Utils().formatDateIndo(value.toString().split(' ')[0]);
    }
    update();
  }

  Rx<String> purpose_transaction = ''.obs;
  TextEditingController purpose_transaction_controller =
      TextEditingController();
  void setPuposeTransaction(String value) {
    purpose_transaction.value = value;
    purpose_transaction_controller.text = value;
  }

  Rx<int> totalproduct_transaction = 0.obs;
  void setTotalProductTransaction(int value) =>
      totalproduct_transaction.value = value;

  Rx<num> totalprice_transaction = 0.obs;
  void setTotalPriceTransaction(num value) =>
      totalprice_transaction.value = value;

  Rx<String> purposedivisi_transaction = ''.obs;
  TextEditingController purposedivisi_transaction_controller =
      TextEditingController();
  void setPurposeDivisiTransaction(String value) {
    purposedivisi_transaction.value = value;
    purposedivisi_transaction_controller.text = value;
  }

  Rx<bool?> isppn_transaction = false.obs;
  void setIsPpnTransaction(bool? value) {
    isppn_transaction.value = value;
    if (value == false) {
      valueppn_transaction.value = 0;
    }
    update();
  }

  Rx<num> valueppn_transaction = 0.obs;
  TextEditingController valueppn_transaction_controller =
      TextEditingController();
  void setValuePpnTransaction(num value) {
    valueppn_transaction.value = value;
    valueppn_transaction_controller.text = value.toString();
  }

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
  TextEditingController nomorvirtual_transaction_controller =
      TextEditingController();
  void setNomorVirtualTransaction(String value) {
    nomorvirtual_transaction.value = value;
    nomorvirtual_transaction_controller.text = value;
  }

  Rx<String> accept_transaction = ''.obs;
  TextEditingController accept_transaction_controller = TextEditingController();
  void setAcceptTransaction(String value) {
    accept_transaction.value = value;
    accept_transaction_controller.text = value;
  }

  Rx<String> bank_transaction = ''.obs;
  TextEditingController bank_transaction_controller = TextEditingController();
  void setBankTransaction(String value) {
    bank_transaction.value = value;
    bank_transaction_controller.text = value;
  }

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
    CTransaksi cTransaksi = Get.put(CTransaksi());
    CDashboard cDashboard = Get.put(CDashboard());

    try {
      if (hasErros()) {
        Utils().showSnackbar(
            'error', 'Faiiled', 'Periksa kembali form inputan anda');
      } else {
        isLoadingSubmit.value = true;

        var response = await FormTransaksiSource.postTransaksi(data);

        if (response['status'] == 400) {
          Utils().showSnackbar('error', 'Failed', response['message']);
        } else {
          Utils().showSnackbar(
              'success', 'Success', 'Berhasil menambahkan transaksi');
          await Future.delayed(const Duration(seconds: 1));
          cTransaksi.resetData();
          cDashboard.resetData();
          Get.offAllNamed(AppRoute.home);
        }
        isLoadingSubmit.value = false;
      }
    } catch (e) {
      print(e);
      isLoadingSubmit.value = false;
      // Utils().showSnackbar('error', 'Failed', 'Terjadi kesalahan');
    }
    update();
  }

  Future<void> updateTransaksi(dynamic data) async {
    CTransaksi cTransaksi = Get.put(CTransaksi());
    CDashboard cDashboard = Get.put(CDashboard());

    try {
      if (hasErros()) {
        Utils().showSnackbar(
            'error', 'Faiiled', 'Periksa kembali form inputan anda');
      } else {
        isLoadingSubmit.value = true;

        var response = await FormTransaksiSource.updateTransaksi(
            transaction_id.value, data);

        if (response['status'] == 400) {
          Utils().showSnackbar('error', 'Failed', response['message']);
        } else {
          Utils().showSnackbar('success', 'Success', response['message']);
          await Future.delayed(const Duration(seconds: 1));
          is_edit.value = false;
          transaction_id.value = 0;
          cTransaksi.resetData();
          cDashboard.resetData();
          Get.offAllNamed(AppRoute.home);
        }
        isLoadingSubmit.value = false;
      }
    } catch (e) {
      print(e);
      isLoadingSubmit.value = false;
      // Utils().showSnackbar('error', 'Failed', 'Terjadi kesalahan');
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getStaticData();
  }

  void resetForm() {
    code_transaction.value = '';
    code_transaction_controller.text = '';

    tanggal_transaction.value = DateTime.now().toString().split(' ')[0];
    tanggal_transaction_controller.text =
        Utils().formatDateIndo(DateTime.now().toString().split(' ')[0]);

    paidto_transaction.value = '';
    paidto_transaction_controller.text = '';

    metode_pembayaran_id.value = '';
    paymentterms_transaction.value = 0;
    expired_transaction.value = DateTime.now().toString().split(' ')[0];
    expired_transaction_controller.text =
        Utils().formatDateIndo(DateTime.now().toString().split(' ')[0]);

    purpose_transaction.value = '';
    purpose_transaction_controller.text = '';

    totalproduct_transaction.value = 0;
    totalprice_transaction.value = 0;
    purposedivisi_transaction.value = '';
    purposedivisi_transaction_controller.text = '';

    isppn_transaction.value = false;
    valueppn_transaction.value = 0;
    valueppn_transaction_controller.text = '0';
    attachment_transaction = File('');
    overbooking_transaction.value = false;
    metodePembayaranList = {}.obs;
    isLoadingMetodePembayaranList.value = true;
    nomorvirtual_transaction.value = '';
    nomorvirtual_transaction_controller.text = '';
    accept_transaction.value = '';
    accept_transaction_controller.text = '';
    bank_transaction.value = '';
    bank_transaction_controller.text = '';
    isLoadingSubmit.value = false;
    getStaticData();
    update();
  }

  Rx<bool> isLoadingDelete = false.obs;
  Future<void> deleteForm(id) async {
    CTransaksi cTransaksi = Get.put(CTransaksi());
    CDashboard cDashboard = Get.put(CDashboard());

    try {
      isLoadingDelete.value = true;
      Response response = await FormTransaksiSource.deleteTransaksi(id);
      if (response.statusCode == 200) {
        Utils().showSnackbar('success', 'Success', response.data);
        await Future.delayed(const Duration(seconds: 1));
        cTransaksi.resetData();
        cDashboard.resetData();
        Get.offAllNamed(AppRoute.home);
      }
      isLoadingDelete.value = false;
    } catch (e) {
      print(e);
      isLoadingDelete.value = false;
      // Utils().showSnackbar('error', 'Failed', 'Terjadi kesalahan');
    }
  }

  Future<void> editForm(id) async {
    try {
      Response response = await FormTransaksiSource.editTransaksi(id);
      if (response.statusCode == 200) {
        final result = response.data['result'];

        is_edit.value = true;
        transaction_id.value = id;

        setCodeTransaction(result['noReq']);
        setTanggalTransaction(DateTime.parse(result['reqDate']), edit: true);
        setPaidToTransaction(result['paidTo']);
        setMetodePembayaranId(result['metode_pembayaran_id'].toString());
        setPaymentTermsTransaction(result['paymentTerms']);
        setExpiredTransaction(DateTime.parse(result['expDate']), edit: true);
        setPuposeTransaction(result['purposeTransaction']);
        setTotalProductTransaction(result['totalProduct'] ?? 0);
        setTotalPriceTransaction(result['totalAmount'] ?? 0);
        setPurposeDivisiTransaction(result['purposeDivisi'] ?? '-');
        setIsPpnTransaction(result['ppn'] == 1 ? true : false);
        setValuePpnTransaction(result['amountPpn'] ?? 0);
        setOverbookingTransaction(
            result['overbooking_transaction'] == 1 ? true : false);
        setNomorVirtualTransaction(result['nomorvirtual_transaction'] ?? '');
        setAcceptTransaction(result['accept_transaction'] ?? '');
        setBankTransaction(result['bank_transaction'] ?? '');
        setBankTransaction(result['bank_transaction'] ?? '');

        final getOverBooking = result['over_booking'];
        cOverBooking.setJenisOverBooking(
            getOverBooking != null ? getOverBooking['jenis_over_booking'] : '');
        cOverBooking.setDariRekeningBooking(getOverBooking != null
            ? getOverBooking['darirekening_booking']
            : '');
        cOverBooking.setPemilikRekening(getOverBooking != null
            ? getOverBooking['pemilikrekening_booking']
            : '');
        cOverBooking.setTujuanRekening(getOverBooking != null
            ? getOverBooking['tujuanrekening_booking']
            : '');
        cOverBooking.setPemilikTujuan(getOverBooking != null
            ? getOverBooking['pemiliktujuan_booking']
            : '');
        cOverBooking.setNominalBooking(
            NumberTextInputFormatter().addThousandSeparator(
                getOverBooking != null
                    ? getOverBooking['nominal_booking'].toString()
                    : null),
            edit: true);

        List<dynamic> getProducts = result['products'];
        print(getProducts);
        for (var element in getProducts) {
          cListProduct.getListProduct.add(ProductList(
                  products_id: element['products_id'],
                  code_product: element['code_product'],
                  name_product: element['name'],
                  capacity_product: element['capacity_product'],
                  remarks_detail: element['remarks'],
                  qty_detail: element['qty'],
                  price_detail: element['price'],
                  subtotal_detail: element['subTotal'],
                  matauang_detail: element['currency'],
                  kurs_detail: element['curs'])
              .toJson);

          cListProduct.remarks_detail_controller
              .add(TextEditingController(text: element['remarks']));
          cListProduct.qty_detail_controller.add(TextEditingController(
              text: NumberTextInputFormatter()
                  .addThousandSeparator(element['qty'].toString())));
          cListProduct.price_detail_controller.add(TextEditingController(
              text: NumberTextInputFormatter()
                  .addThousandSeparator(element['price'].toString())));
          cListProduct.kurs_detail_controller
              .add(TextEditingController(text: element['curs'].toString()));
        }

        Get.toNamed(AppRoute.formTransaction);
      }
    } catch (e) {
      print(e);
      // Utils().showSnackbar('error', 'Failed', 'Terjadi kesalahan');
    }
  }
}
