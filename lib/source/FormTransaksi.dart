// ignore_for_file: unnecessary_new
import 'package:dio/dio.dart';
import 'package:e_form/config/api_service.dart';
import 'package:e_form/config/utils.dart';

class FormTransaksiSource {
  static Future<Map<String, dynamic>> dataStatic() async {
    try {
      Response transaksi = await ApiService().get(
        '/transaksi/static',
      );
      return transaksi.data;
    } catch (e) {
      Utils().printError(e);
      return {};
    }
  }

  static Future<Map<String, dynamic>> postTransaksi(dynamic data) async {
    try {
      Response transaksi = await ApiService().post('/transaksi', data);
      return transaksi.data;
    } catch (e) {
      Utils().printError(e);
      return {};
    }
  }
}
