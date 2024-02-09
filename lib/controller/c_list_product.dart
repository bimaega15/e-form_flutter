// ignore_for_file: non_constant_identifier_names

import 'package:e_form/source/FormTransaksi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

class ProductList {
  final int products_id;
  final String code_product;
  final String name_product;
  final String capacity_product;
  final String remarks_detail;
  final num qty_detail;
  final num price_detail;
  final num subtotal_detail;
  final String matauang_detail;
  final num kurs_detail;

  ProductList({
    required this.products_id,
    required this.code_product,
    required this.name_product,
    required this.capacity_product,
    required this.remarks_detail,
    required this.qty_detail,
    required this.price_detail,
    required this.subtotal_detail,
    required this.matauang_detail,
    required this.kurs_detail,
  });

  Map<String, dynamic> get toJson {
    return {
      "products_id": products_id,
      "code_product": code_product,
      "name_product": name_product,
      "capacity_product": capacity_product,
      "remarks_detail": remarks_detail,
      "qty_detail": qty_detail,
      "price_detail": price_detail,
      "subtotal_detail": subtotal_detail,
      "matauang_detail": matauang_detail,
      "kurs_detail": kurs_detail,
    };
  }
}

class CListProduct extends GetxController {
  List<dynamic> getListProduct = [].obs;
  List<TextEditingController> remarks_detail_controller = [];
  List<TextEditingController> qty_detail_controller = [];
  List<TextEditingController> price_detail_controller = [];
  List<TextEditingController> kurs_detail_controller = [];

  RxMap getListDataStatic = {}.obs;
  Rx<String> valueListDataStatic = ''.obs;
  List<Map<String, String>> productListError = List.generate(
      50,
      (index) => {
            "remarks_detail": "",
            "qty_detail": "",
            "price_detail": "",
            "kurs_detail": "",
          });

  void addError(String field, String message, {int index = 0}) {
    Map<String, String> updatedItem = Map.from(productListError[index]);
    updatedItem[field] = message;
    productListError[index] = updatedItem;

    update();
  }

  bool hasErros() {
    bool isError = false;

    List<int> emptyIndexesRemarks = [];
    List<int> noEmptyIndexesRemarks = [];
    getListProduct.asMap().forEach((index, item) {
      if (item['remarks_detail'] == null || item['remarks_detail'] == '') {
        emptyIndexesRemarks.add(index);
      } else {
        noEmptyIndexesRemarks.add(index);
      }
    });

    if (emptyIndexesRemarks.isNotEmpty) {
      isError = true;
      for (int index in emptyIndexesRemarks) {
        addError('remarks_detail', 'Remarks tidak boleh kosong', index: index);
      }
    }

    if (noEmptyIndexesRemarks.isNotEmpty) {
      for (int index in noEmptyIndexesRemarks) {
        addError('remarks_detail', '', index: index);
      }
    }

    List<int> emptyIndexesQty = [];
    List<int> noEmptyIndexesQty = [];
    getListProduct.asMap().forEach((index, item) {
      if (item['qty_detail'] == null ||
          item['qty_detail'] == '' ||
          item['qty_detail'] == 0) {
        emptyIndexesQty.add(index);
      } else {
        noEmptyIndexesQty.add(index);
      }
    });

    if (emptyIndexesQty.isNotEmpty) {
      isError = true;

      for (int index in emptyIndexesQty) {
        addError('qty_detail', 'Qty tidak boleh kosong', index: index);
      }
    }

    if (noEmptyIndexesQty.isNotEmpty) {
      for (int index in noEmptyIndexesQty) {
        addError('qty_detail', '', index: index);
      }
    }

    List<int> emptyIndexesPrice = [];
    List<int> noEmptyIndexesPrice = [];
    getListProduct.asMap().forEach((index, item) {
      if (item['price_detail'] == null ||
          item['price_detail'] == '' ||
          item['price_detail'] == 0) {
        emptyIndexesPrice.add(index);
      } else {
        noEmptyIndexesPrice.add(index);
      }
    });

    if (emptyIndexesPrice.isNotEmpty) {
      isError = true;

      for (int index in emptyIndexesRemarks) {
        addError('price_detail', 'Price tidak boleh kosong', index: index);
      }
    }
    if (noEmptyIndexesPrice.isNotEmpty) {
      for (int index in noEmptyIndexesPrice) {
        addError('price_detail', '', index: index);
      }
    }

    List<int> emptyIndexesKurs = [];
    List<int> noEmptyIndexesKurs = [];
    getListProduct.asMap().forEach((index, item) {
      if (item['kurs_detail'] == null ||
          item['kurs_detail'] == '' ||
          item['kurs_detail'] == 0) {
        emptyIndexesKurs.add(index);
      } else {
        noEmptyIndexesKurs.add(index);
      }
    });

    if (emptyIndexesKurs.isNotEmpty) {
      isError = true;
      for (int index in emptyIndexesKurs) {
        addError('kurs_detail', 'kurs tidak boleh kosong', index: index);
      }
    }
    if (noEmptyIndexesKurs.isNotEmpty) {
      for (int index in noEmptyIndexesKurs) {
        addError('kurs_detail', '', index: index);
      }
    }

    return isError;
  }

  void setValueDataStatic(String? value) {
    valueListDataStatic.value = value!;
    update();
  }

  void setListProduct(Map<dynamic, dynamic> value) {
    bool productExists =
        getListProduct.any((item) => item['products_id'] == value['id']);

    if (productExists) {
      int index = getListProduct
          .indexWhere((item) => item['products_id'] == value['id']);
      getListProduct[index]['qty_detail'] += 1;
    } else {
      getListProduct.add(ProductList(
              products_id: value['id'],
              code_product: value['code_product'],
              name_product: value['name_product'],
              capacity_product: value['capacity_product'],
              remarks_detail: '',
              qty_detail: 0,
              price_detail: 0,
              subtotal_detail: 0,
              matauang_detail: 'USD',
              kurs_detail: 0)
          .toJson);

      remarks_detail_controller.add(TextEditingController(text: ''));
      qty_detail_controller.add(TextEditingController(text: '0'));
      price_detail_controller.add(TextEditingController(text: '0'));
      kurs_detail_controller.add(TextEditingController(text: '0'));
    }
    update();
  }

  void updateListProduct(value, Map<dynamic, dynamic> dataProduct, type) {
    bool productExists = getListProduct
        .any((item) => item['products_id'] == dataProduct['products_id']);

    if (productExists) {
      int index = getListProduct.indexWhere(
          (item) => item['products_id'] == dataProduct['products_id']);
      var resultValue = (type == 'price_detail' || type == 'qty_detail')
          ? (value != null && value != '')
              ? int.parse(value.replaceAll(',', ''))
              : 0
          : value;
      getListProduct[index][type] = resultValue;

      if (type == 'price_detail') {
        var price_detail = resultValue;
        var qty_detail = getListProduct[index]['qty_detail'];

        if (qty_detail is String) {
          qty_detail = int.parse(qty_detail);
        }
        if (price_detail is String) {
          price_detail = int.parse(price_detail);
        }

        var subtotal_detail = price_detail * qty_detail;
        getListProduct[index]['subtotal_detail'] = subtotal_detail;
      }
      if (type == 'qty_detail') {
        var qty_detail = resultValue;
        var price_detail = getListProduct[index]['price_detail'];

        if (qty_detail is String) {
          qty_detail = int.parse(qty_detail);
        }
        if (price_detail is String) {
          price_detail = int.parse(price_detail);
        }

        var subtotal_detail = price_detail * qty_detail;
        getListProduct[index]['subtotal_detail'] = subtotal_detail;
      }

      update();
    }
  }

  void removeListProduct(value) {
    bool productExists = getListProduct
        .any((item) => item['products_id'] == value['products_id']);
    if (productExists) {
      int index = getListProduct
          .indexWhere((item) => item['products_id'] == value['products_id']);
      getListProduct.removeAt(index);
      remarks_detail_controller.removeAt(index);
      qty_detail_controller.removeAt(index);
      price_detail_controller.removeAt(index);
      kurs_detail_controller.removeAt(index);
      update();
    }
  }

  void getStaticData() async {
    final response = await FormTransaksiSource.dataStatic();
    getListDataStatic.value = response['result'];
    List<dynamic> defaultValueCurrency = response['result']['mataUang'];

    valueListDataStatic.value = defaultValueCurrency.first['id'].toString();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getStaticData();
  }

  @override
  void onClose() {
    for (var controller in remarks_detail_controller) {
      controller.dispose();
    }
    for (var controller in qty_detail_controller) {
      controller.dispose();
    }
    for (var controller in price_detail_controller) {
      controller.dispose();
    }
    for (var controller in kurs_detail_controller) {
      controller.dispose();
    }
    super.onClose();
  }

  void resetForm() {
    getListProduct = [].obs;
    remarks_detail_controller = [];
    qty_detail_controller = [];
    price_detail_controller = [];
    kurs_detail_controller = [];
    getListDataStatic = {}.obs;
    valueListDataStatic.value = '';
    productListError = List.generate(
        50,
        (index) => {
              "remarks_detail": "",
              "qty_detail": "",
              "price_detail": "",
              "kurs_detail": "",
            });
    getStaticData();
    update();
  }
}
