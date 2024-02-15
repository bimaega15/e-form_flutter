// ignore_for_file: avoid_print

import 'package:e_form/controller/c_auth.dart';
import 'package:e_form/controller/c_menubar.dart';
import 'package:e_form/controller/c_transaksi.dart';
import 'package:e_form/source/DashboardSource.dart';
import 'package:get/get.dart' hide Response;

class DashboardData {
  Map<String, dynamic> result;

  DashboardData({required this.result});

  Map<String, dynamic> get toJson {
    return {
      "result": result,
    };
  }
}

class StatusData {
  late int menunggu;
  late int disetujui;
  late int ditolak;
  late int accesorSetuju;
  late int accesorDitolak;
  late int accesorRevisi;

  StatusData({
    required this.menunggu,
    required this.disetujui,
    required this.ditolak,
    required this.accesorSetuju,
    required this.accesorDitolak,
    required this.accesorRevisi,
  });

  Map<String, dynamic> get toJson {
    return {
      "Menunggu": menunggu,
      "Disetujui": disetujui,
      "Ditolak": ditolak,
      "Accesor Setuju": accesorSetuju,
      "Accesor Ditolak": accesorDitolak,
      "Accesor Revisi": accesorRevisi,
    };
  }
}

class CDashboard extends GetxController {
  Rx<DashboardData> getDashboardData = DashboardData(result: {}).obs;
  Rx<StatusData> getStatusData = StatusData(
          menunggu: 0,
          disetujui: 0,
          ditolak: 0,
          accesorSetuju: 0,
          accesorDitolak: 0,
          accesorRevisi: 0)
      .obs;
  RxBool isLoading = true.obs;
  Rx<String> searchByNoTracking = ''.obs;
  CTransaksi cTransaksi = Get.put(CTransaksi());
  CMenuBar cMenuBar = Get.put(CMenuBar());
  void setSearchByNoTracking(String value) {
    searchByNoTracking.value = value;
    cTransaksi.searchTransaksiText.value = value;
    cTransaksi.search_transaksi_controller.text = value;
  }

  void onSearchTracking() {
    cTransaksi.searchTransaksi(searchByNoTracking.value);
    cMenuBar.indexPage = 2;
    update();
  }

  final cAuth = Get.put(CAuth());

  void setTransaksi(Map<String, dynamic> userData) {
    DashboardData data = DashboardData(result: userData['result']);
    getDashboardData.value = data;

    StatusData statusData = StatusData(
        menunggu: userData['result']['totalWaiting'],
        disetujui: userData['result']['totalSuccess'],
        ditolak: userData['result']['totalReject'],
        accesorSetuju: userData['result']['totalSuccessAccesor'],
        accesorDitolak: userData['result']['totalRejectAccesor'],
        accesorRevisi: userData['result']['totalWaitingAccesor']);
    getStatusData.value = statusData;
  }

  void getTransaksi() async {
    try {
      final getTransaksi = await DashboardSource.transaksi();
      setTransaksi(getTransaksi);
      isLoading.value = false;
    } catch (error) {
      print(error);
      // Utils().showSnackbar('error', 'Failed', 'Terjadi kesalahan');
    }

    update();
  }

  void resetData() {
    getDashboardData.value = DashboardData(result: {});
    getStatusData.value = StatusData(
        menunggu: 0,
        disetujui: 0,
        ditolak: 0,
        accesorSetuju: 0,
        accesorDitolak: 0,
        accesorRevisi: 0);
    isLoading.value = true;
    searchByNoTracking.value = '';
  }
}
