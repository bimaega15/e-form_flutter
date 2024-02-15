// ignore_for_file: await_only_futures, non_constant_identifier_names

import 'package:e_form/controller/c_form_transaksi.dart';
import 'package:e_form/source/TransaksiSource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:intl/intl.dart';

class CTransaksi extends GetxController {
  var menungguList = [].obs;
  var isLoadingMenunggu = false.obs;
  var currentPageMenunggu = 1;
  var hasMoreDataMenunggu = true.obs;

  var disetujuiList = [].obs;
  var isLoadingDisetujui = false.obs;
  var currentPageDisetujui = 1;
  var hasMoreDataDisetujui = true.obs;

  var ditolakList = [].obs;
  var isLoadingDitolak = false.obs;
  var currentPageDitolak = 1;
  var hasMoreDataDitolak = true.obs;

  var direvisiList = [].obs;
  var isLoadingDirevisi = false.obs;
  var currentPageDirevisi = 1;
  var hasMoreDataDirevisi = true.obs;

  var semuaList = [].obs;
  var isLoadingSemua = false.obs;
  var currentPageSemua = 1;
  var hasMoreDataSemua = true.obs;

  Rx<bool> isExpired = false.obs;
  Rx<String> tanggalAwalFilter =
      DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  Rx<String> tanggalAkhirFilter =
      DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;

  Rx<String> searchTransaksiText = ''.obs;
  TextEditingController search_transaksi_controller = TextEditingController();

  CFormTransaksi cFormTransaksi = Get.put(CFormTransaksi());

  void fetchTransakiMenunggu() async {
    if (!hasMoreDataMenunggu.value) {
      return;
    }

    isLoadingMenunggu(true);
    var result = await TransaksiSource.transaksiPagination(
        'menunggu', currentPageMenunggu, '');
    var resultData = result['result'];
    menungguList.addAll(resultData['data']);
    isLoadingMenunggu(false);
    currentPageMenunggu++;
    hasMoreDataMenunggu(resultData['next_page_url'] != null);
    update();
  }

  void fetchTransakiDisetujui() async {
    if (!hasMoreDataDisetujui.value) {
      return;
    }

    isLoadingDisetujui(true);

    var result = await TransaksiSource.transaksiPagination(
        'disetujui', currentPageDisetujui, '');
    var resultData = result['result'];
    disetujuiList.addAll(resultData['data']);
    isLoadingDisetujui(false);
    currentPageDisetujui++;
    hasMoreDataDisetujui(resultData['next_page_url'] != null);

    update();
  }

  void fetchTransakiDitolak() async {
    if (!hasMoreDataDitolak.value) {
      return;
    }

    isLoadingDitolak(true);

    var result = await TransaksiSource.transaksiPagination(
        'ditolak', currentPageDitolak, '');
    var resultData = result['result'];
    ditolakList.addAll(resultData['data']);
    isLoadingDitolak(false);
    currentPageDitolak++;
    hasMoreDataDitolak(resultData['next_page_url'] != null);

    update();
  }

  void fetchTransakiDirevisi() async {
    if (!hasMoreDataDirevisi.value) {
      return;
    }

    isLoadingDirevisi(true);

    var result = await TransaksiSource.transaksiPagination(
        'direvisi', currentPageDirevisi, '');
    var resultData = result['result'];
    direvisiList.addAll(resultData['data']);
    isLoadingDirevisi(false);
    currentPageDirevisi++;
    hasMoreDataDirevisi(resultData['next_page_url'] != null);

    update();
  }

  void fetchTransakiSemua(String search,
      {bool onSearch = false,
      tanggal_awal = '',
      tanggal_akhir = '',
      is_transaksi_expired = false}) async {
    try {
      if (!hasMoreDataSemua.value) {
        return;
      }
      isLoadingSemua(true);

      var result = await TransaksiSource.transaksiPagination(
        '',
        currentPageSemua,
        search.toString(),
        is_transaksi_expired: is_transaksi_expired,
        tanggal_awal: tanggal_awal,
        tanggal_akhir: tanggal_akhir,
      );
      var resultData = result['result'];
      if (onSearch) {
        semuaList.clear();
      }
      if (search.isNotEmpty && search != '' && onSearch) {
        semuaList.value = resultData['data'];
      } else {
        if (!(semuaList.isNotEmpty &&
            currentPageSemua == 1 &&
            search.isNotEmpty &&
            search != '')) {
          semuaList.addAll(resultData['data']);
        }
      }
      isLoadingSemua(false);
      if (onSearch) {
        currentPageSemua = 1;
        hasMoreDataSemua(resultData['next_page_url'] != null);
      } else {
        currentPageSemua++;
        hasMoreDataSemua(resultData['next_page_url'] != null);
      }

      update();
    } catch (e) {
      print(e);
      semuaList.clear();
      isLoadingSemua(false);
      update();
    }
  }

  void searchTransaksi(String value) async {
    searchTransaksiText.value = value;
    hasMoreDataSemua(true);
    currentPageSemua = 1;

    fetchTransakiSemua(value, onSearch: true);
    update();
  }

  void initialData() {
    fetchTransakiMenunggu();
    fetchTransakiDisetujui();
    fetchTransakiDitolak();
    fetchTransakiDirevisi();
    fetchTransakiSemua(searchTransaksiText.value,
        onSearch: false,
        is_transaksi_expired: isExpired.value,
        tanggal_akhir: tanggalAkhirFilter.value,
        tanggal_awal: tanggalAwalFilter.value);
  }

  void resetTransaksiMenunggu() {
    menungguList.clear();
    isLoadingMenunggu.value = false;
    currentPageMenunggu = 1;
    hasMoreDataMenunggu(true);
  }

  void resetDisetujuiList() {
    disetujuiList.clear();
    isLoadingDisetujui.value = false;
    currentPageDisetujui = 1;
    hasMoreDataDisetujui.value = true;
  }

  void resetDitolakList() {
    ditolakList.clear();
    isLoadingDitolak.value = false;
    currentPageDitolak = 1;
    hasMoreDataDitolak.value = true;
  }

  void resetDirevisiList() {
    direvisiList.clear();
    isLoadingDirevisi.value = false;
    currentPageDirevisi = 1;
    hasMoreDataDirevisi.value = true;
  }

  void resetSemuaList() {
    semuaList.clear();
    isLoadingSemua.value = false;
    currentPageSemua = 1;
    hasMoreDataSemua.value = true;
  }

  void resetData() {
    resetTransaksiMenunggu();
    resetDisetujuiList();
    resetDitolakList();
    resetDirevisiList();
    resetSemuaList();
  }

  void resetFilter() {
    isExpired.value = false;
    tanggalAwalFilter.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
    tanggalAkhirFilter.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }
}
