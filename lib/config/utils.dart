import 'package:e_form/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Utils {
  double widthMobileUI = 393;
  double heightMobileUI = 852;
  String baseApi = 'http://172.23.192.1/e_form/public/api';
  String baseRoot = 'http://172.23.192.1/e_form/public';

  double calculateResponsiveWidth(double width, BuildContext context) {
    return (MediaQuery.of(context).size.width * width) / widthMobileUI;
  }

  double calculateResponsiveHeight(double height, BuildContext context) {
    return (MediaQuery.of(context).size.height * height) / heightMobileUI;
  }

  String toTitleCase(String text) {
    if (text.isEmpty) {
      return '';
    }

    return text[0].toUpperCase() + text.substring(1);
  }

  void showSnackbar(type, title, message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: type == 'error'
          ? AppColor.errorColor
          : type == 'success'
              ? AppColor.secondary
              : AppColor.mainText,
      colorText: AppColor.textColor,
      duration: const Duration(milliseconds: 3000),
      snackPosition: SnackPosition.TOP,
    );
  }

  void printError(e) {
    print(['e print', e]);
    showSnackbar('error', 'Failed', e['message']);
  }

  String formatDateIndo(dataDate) {
    DateTime myDate = DateTime.parse(dataDate);
    String formattedDate = DateFormat('dd MMMM yyyy', 'id').format(myDate);
    return formattedDate;
  }

  String formatMoneyCurrency(nominal) {
    String formattedAmount = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(nominal);

    return formattedAmount;
  }

  String capitalizeEachWord(String input) {
    List<String> words = input.split(' ');

    // Capitalize each word
    List<String> capitalizedWords = words.map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      } else {
        return word;
      }
    }).toList();

    // Join the words back together
    String result = capitalizedWords.join(' ');

    return result;
  }
}
