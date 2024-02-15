// ignore_for_file: non_constant_identifier_names

import 'package:e_form/source/ProdukSource.dart';
import 'package:get/get.dart' hide Response;

class CSearchProduct extends GetxController {
  Rx<bool> isFocused = false.obs;
  Rx<bool> isLoading = false.obs;
  List<dynamic> semuaProduct = [].obs;
  int currentPage = 1;
  Rx<bool> hasMoreData = true.obs;
  Rx<String> searchProductText = ''.obs;
  void setSearchProductText(String value) {
    searchSemuaProduct(value);
    update();
  }

  void setFocused(bool value) {
    currentPage = 1;
    if (value) {
      fetchProduksi(searchProductText.value);
    } else {
      semuaProduct.clear();
      hasMoreData(true);
    }
    isFocused.value = value;
    update();
  }

  void searchSemuaProduct(String value) async {
    searchProductText.value = value;
    hasMoreData(true);
    currentPage = 1;

    fetchProduksi(value, onSearch: true);
    update();
  }

  void fetchProduksi(String search, {bool onSearch = false}) async {
    try {
      if (!hasMoreData.value) {
        return;
      }

      isLoading(true);
      var result = await ProdukSource.produkPagination(currentPage, search);
      var resultData = result['result'];
      if (onSearch) {
        semuaProduct.clear();
      }
      if (search.isNotEmpty && search != '' && onSearch) {
        semuaProduct = resultData['data'];
      } else {
        if (!(semuaProduct.isNotEmpty &&
            currentPage == 1 &&
            search.isNotEmpty &&
            search != '')) {
          semuaProduct.addAll(resultData['data']);
        }
      }
      if (onSearch) {
        currentPage = 1;
        hasMoreData(resultData['next_page_url'] != null);
      } else {
        currentPage++;
        hasMoreData(resultData['next_page_url'] != null);
      }
      isLoading(false);
      update();
    } catch (e) {
      print(e);
      semuaProduct.clear();
      isLoading(false);
      update();
    }
  }
}
