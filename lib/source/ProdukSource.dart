// ignore_for_file: unnecessary_new
import 'package:dio/dio.dart';
import 'package:e_form/config/api_service.dart';
import 'package:e_form/config/utils.dart';

class ProdukSource {
  static Future<Map<String, dynamic>> produkPagination(
      int page, String search) async {
    try {
      var queryParameters = {
        'search': search,
        'page': page,
      };
      Response produk =
          await ApiService().get('/produk', queryParameters: queryParameters);
      return produk.data;
    } catch (e) {
      Utils().printError(e);
      return {};
    }
  }
}
