// ignore_for_file: non_constant_identifier_names

import 'package:e_form/config/app_color.dart';
import 'package:e_form/config/app_route.dart';
import 'package:e_form/config/utils.dart';
import 'package:e_form/controller/c_transaksi.dart';
import 'package:e_form/widget/button_primary.dart';
import 'package:e_form/widget/text_input_with_label.dart';
import 'package:e_form/widget/text_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class FilterTransaction extends StatefulWidget {
  const FilterTransaction({super.key});

  @override
  State<FilterTransaction> createState() => _FilterTransactionState();
}

class _FilterTransactionState extends State<FilterTransaction> {
  CTransaksi cTransaksi = Get.put(CTransaksi());
  bool isShowExpired = true;
  String _range = '';
  DateTime result_tanggal_awal = DateTime.now();
  DateTime result_tanggal_akhir = DateTime.now();
  TextEditingController periodeTransaksi = TextEditingController(
      text:
          '${DateFormat('dd/MM/yyyy').format(DateTime.now())} - ${DateFormat('dd/MM/yyyy').format(DateTime.now())}');

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
        periodeTransaksi.text = _range;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    var tanggal_awal = cTransaksi.tanggalAwalFilter.value;
    var tanggal_akhir = cTransaksi.tanggalAkhirFilter.value;

    var result_tanggal_awal_var = tanggal_awal != ''
        ? Utils().formatDateFilter(tanggal_awal)
        : DateFormat('dd/MM/yyyy').format(DateTime.now());
    var result_tanggal_akhir_var = tanggal_akhir != ''
        ? Utils().formatDateFilter(tanggal_akhir)
        : DateFormat('dd/MM/yyyy').format(DateTime.now());

    var splitTanggalAwal = result_tanggal_awal_var.split('/');
    var splitTanggalAkhir = result_tanggal_akhir_var.split('/');
    DateTime set_tanggal_awal = DateTime.now();
    DateTime set_tanggal_akhir = DateTime.now();

    if (splitTanggalAwal.isNotEmpty) {
      set_tanggal_awal = DateTime(int.parse(splitTanggalAwal[2]),
          int.parse(splitTanggalAwal[1]), int.parse(splitTanggalAwal[0]));
    }
    if (splitTanggalAkhir.isNotEmpty) {
      set_tanggal_akhir = DateTime(int.parse(splitTanggalAkhir[2]),
          int.parse(splitTanggalAkhir[1]), int.parse(splitTanggalAkhir[0]));
    }
    setState(() {
      isShowExpired = cTransaksi.isExpired.value;
      periodeTransaksi.text =
          '$result_tanggal_awal_var - $result_tanggal_akhir_var';
      _range = '$result_tanggal_awal_var - $result_tanggal_akhir_var';
      result_tanggal_awal = set_tanggal_awal;
      result_tanggal_akhir = set_tanggal_akhir;
    });
  }

  void onFilter() {
    var response = Utils().parseDateRange(periodeTransaksi.text);
    cTransaksi.resetData();

    cTransaksi.isExpired.value = isShowExpired;
    cTransaksi.tanggalAwalFilter.value = response['tanggal_awal']!;
    cTransaksi.tanggalAkhirFilter.value = response['tanggal_akhir']!;
    Get.offAllNamed(AppRoute.home);
  }

  void resetFilter() {
    cTransaksi.resetFilter();
    cTransaksi.resetData();
    Get.offAllNamed(AppRoute.home);
  }

  @override
  void dispose() {
    super.dispose();
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
          'Filter History',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              TextInputWithLabel(
                label: 'Periode Transaksi',
                controller: periodeTransaksi,
              ),
              SfDateRangePicker(
                onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.range,
                initialSelectedRange:
                    PickerDateRange(result_tanggal_awal, result_tanggal_akhir),
              ),
              const SizedBox(
                height: 10,
              ),
              const TextMain(text: 'Tampilkan Expired'),
              CheckboxListTile(
                title: const TextMain(text: 'Tampilkan'),
                value: isShowExpired,
                onChanged: (bool? value) {
                  setState(() {
                    isShowExpired = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: AppColor.borderColor,
                thickness: 0.2,
              ),
              Row(
                children: [
                  Expanded(
                    child: ButtonPrimary(
                      label: 'Reset',
                      color: AppColor.errorColor,
                      onTap: () {
                        resetFilter();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ButtonPrimary(
                      label: 'Filter',
                      color: AppColor.secondary,
                      onTap: () {
                        onFilter();
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
