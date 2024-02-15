// ignore_for_file: unnecessary_new, avoid_print, file_names
import 'package:dio/dio.dart';
import 'package:e_form/config/api_service.dart';

class FormTransaksiSource {
  static Future dataStatic() async {
    try {
      Response transaksi = await ApiService().get(
        '/transaksi/static',
      );
      return transaksi.data;
    } catch (e) {
      print(e);
    }
  }

  static Future postTransaksi(dynamic data) async {
    try {
      Response transaksi = await ApiService().post('/transaksi', data);
      return transaksi.data;
    } catch (e) {
      print(e);
    }
  }

  static Future updateTransaksi(int id, dynamic data) async {
    try {
      Response transaksi =
          await ApiService().post('/transaksi/$id/update?_method=put', data);
      return transaksi.data;
    } catch (e) {
      print(e);
    }
  }

  static deleteTransaksi(int id) async {
    try {
      Response transaksi =
          await ApiService().post('/transaksi/$id/destroy?_method=delete', {});
      return transaksi;
    } catch (e) {
      print(e);
    }
  }

  static editTransaksi(int id) async {
    try {
      Response transaksi = await ApiService().get('/transaksi/$id/edit');
      return transaksi;
    } catch (e) {
      print(e);
    }
  }

  static forwardTransaction(Map<dynamic, dynamic> data) async {
    try {
      Response transaction =
          await ApiService().post('/transaksi/forwardApproval', data);
      return transaction;
    } catch (e) {
      print(e);
    }
  }

  static finishTransaction(Map<dynamic, dynamic> data) async {
    try {
      Response transaction =
          await ApiService().post('/transaksi/finishApproval', data);
      return transaction;
    } catch (e) {
      print(e);
    }
  }
}
