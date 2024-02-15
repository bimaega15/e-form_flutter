// ignore_for_file: unnecessary_new
import 'package:dio/dio.dart';
import 'package:e_form/config/api_service.dart';

class TransaksiSource {
  static Future transaksiPagination(
      String statusTransaction, int page, String search) async {
    try {
      var queryParameters = {
        'status_transaction': statusTransaction,
        'search': search,
        'page': page,
      };
      Response transaksi = await ApiService()
          .get('/transaksi/paginate', queryParameters: queryParameters);
      return transaksi.data;
    } catch (e) {
      print(e);
    }
  }
}
