// ignore_for_file: unnecessary_new
import 'package:dio/dio.dart';
import 'package:e_form/config/api_service.dart';

class DashboardSource {
  static Future transaksi() async {
    try {
      Response transaksi = await ApiService().get('/transaksi');
      return transaksi.data;
    } catch (e) {
      print(e);
    }
  }
}
