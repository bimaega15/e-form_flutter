// ignore_for_file: invalid_use_of_protected_member

import 'package:e_form/config/app_color.dart';
import 'package:e_form/controller/c_form_transaksi.dart';
import 'package:e_form/controller/c_transaksi.dart';
import 'package:e_form/widget/list_transaction_pagination.dart';
import 'package:e_form/widget/search_data.dart';
import 'package:e_form/widget/title_and_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  CTransaksi cTransaksi = Get.put(CTransaksi());
  CFormTransaksi cFormTransaksi = Get.put(CFormTransaksi());

  @override
  void initState() {
    super.initState();
    cTransaksi.initialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundScaffold,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          'Transaksi Pengajuan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          const SizedBox(height: 10),
          const TitleAndSubtitle(
            title: 'List Transaction',
            description: 'Berikut merupakan keseluruhan data\ntransaction',
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SearchData(
              hintText: 'Cari tracking anda',
              onChanged: cTransaksi.searchTransaksi,
              controller: cTransaksi.search_transaksi_controller,
            ),
          ),
          const SizedBox(height: 10),
          GetBuilder<CTransaksi>(
              init: CTransaksi(),
              builder: (controller) {
                if (controller.isLoadingSemua.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final myResult = controller.semuaList.value;

                  return NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!controller.isLoadingSemua.value &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        controller.fetchTransakiSemua(
                            controller.searchTransaksiText.value,
                            onSearch: false);
                        return true;
                      }
                      return false;
                    },
                    child: ListTransactionPagination(
                      dataTransaction: myResult,
                      height: 400,
                    ),
                  );
                }
              }),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    cTransaksi.resetData();
  }
}
