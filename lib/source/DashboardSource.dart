// ignore_for_file: unnecessary_new
import 'package:dio/dio.dart';
import 'package:e_form/config/api_service.dart';
import 'package:e_form/config/utils.dart';

class DashboardSource {
  static Future<Map<String, dynamic>> transaksi() async {
    try {
      Response transaksi = await ApiService().get('/transaksi');
      return transaksi.data;
    } catch (e) {
      Utils().printError(e);
      return {};
    }
  }
}
