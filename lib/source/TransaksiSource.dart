// ignore_for_file: unnecessary_new, avoid_print, non_constant_identifier_names, file_names
import 'package:dio/dio.dart';
import 'package:e_form/config/api_service.dart';

class TransaksiSource {
  static Future transaksiPagination(
      String statusTransaction, int page, String search,
      {tanggal_awal = '',
      tanggal_akhir = '',
      is_transaksi_expired = false}) async {
    try {
      var queryParameters = {
        'status_transaction': statusTransaction,
        'search': search,
        'page': page,
        'tanggal_awal': tanggal_awal,
        'tanggal_akhir': tanggal_akhir,
        'is_transaksi_expired': is_transaksi_expired,
      };
      Response transaksi = await ApiService()
          .get('/transaksi/paginate', queryParameters: queryParameters);
      return transaksi.data;
    } catch (e) {
      print(e);
    }
  }
}
