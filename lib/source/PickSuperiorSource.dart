// ignore_for_file: unnecessary_new
import 'package:dio/dio.dart';
import 'package:e_form/config/api_service.dart';

class PickSuperiorSource {
  static Future getUsersProfile(
      int page, int transactionId, String search) async {
    try {
      var queryParameters = {
        'page': page,
        'transaction_id': transactionId,
        'search': search,
      };
      Response responseData = await ApiService().get(
          '/setting/users/getUsersProfile',
          queryParameters: queryParameters);
      return responseData;
    } catch (e) {
      print(e);
    }
  }
}
