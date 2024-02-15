// ignore_for_file: unnecessary_new, avoid_print, file_names
import 'package:dio/dio.dart';
import 'package:e_form/config/api_service.dart';

class ProdukSource {
  static Future produkPagination(int page, String search) async {
    try {
      var queryParameters = {
        'search': search,
        'page': page,
      };
      Response produk =
          await ApiService().get('/produk', queryParameters: queryParameters);
      return produk.data;
    } catch (e) {
      print(e);
    }
  }
}
