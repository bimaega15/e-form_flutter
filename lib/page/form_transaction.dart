// ignore_for_file: avoid_print, invalid_use_of_protected_member, must_be_immutable, unnecessary_null_comparison, non_constant_identifier_names, prefer_final_fields

import 'dart:convert';
import 'dart:io';

import 'package:e_form/config/app_color.dart';
import 'package:e_form/config/number_text_formatter.dart';
import 'package:e_form/controller/c_form_transaksi.dart';
import 'package:e_form/controller/c_list_product.dart';
import 'package:e_form/controller/c_overbooking.dart';
import 'package:e_form/controller/c_search_product.dart';
import 'package:e_form/models/formTransaksi.dart';
import 'package:e_form/widget/button_primary.dart';
import 'package:e_form/widget/search_data.dart';
import 'package:e_form/widget/text_input_with_label.dart';
import 'package:e_form/widget/text_main.dart';
import 'package:e_form/widget/title_and_subtitle.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class FormTransaction extends StatefulWidget {
  const FormTransaction({super.key});

  @override
  State<FormTransaction> createState() => _FormTransactionState();
}

class _FormTransactionState extends State<FormTransaction> {
  String dropdownValue = list.first;
  bool isChecked = false;

  int currentStep = 0;

  CFormTransaksi cFormTransaksi = Get.put(CFormTransaksi());
  CListProduct cListProduct = Get.put(CListProduct());
  COverBooking cOverBooking = Get.put(COverBooking());

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final dataTanggalTransaction =
        DateTime.parse(cFormTransaksi.tanggal_transaction.value);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dataTanggalTransaction,
      firstDate: DateTime(1990),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      cFormTransaksi.setTanggalTransaction(picked);
    }
  }

  Future<void> _selectDateExpired(BuildContext context) async {
    final dataExpiredTransaction =
        DateTime.parse(cFormTransaksi.expired_transaction.value);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dataExpiredTransaction,
      firstDate: DateTime(1990),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      cFormTransaksi.setExpiredTransaction(picked);
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      cFormTransaksi.setAttachmentTransaction(File(result.files.single.path!));
    }
  }

  FocusNode _focusNode = FocusNode();
  CSearchProduct cSearchProduct = Get.put(CSearchProduct());
  TextInputFormatter _formatter = NumberTextInputFormatter();

  Future<void> onSubmit() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Obx(() => AlertDialog(
              title: const TextMain(
                text: 'Submit Confirmation',
                textFontWeight: FontWeight.bold,
                size: 24,
              ),
              content: const Text(
                  'Apakah anda yakin ingin submit seluruh data yang ada di dalam form?\n'),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Tidak'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: cFormTransaksi.isLoadingSubmit.value
                      ? const CircularProgressIndicator()
                      : const Text('Submit'),
                  onPressed: () {
                    formSubmit();

                    if (!cFormTransaksi.isLoadingSubmit.value) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ));
      },
    );
  }

  void formSubmit() {
    bool? overBooking = cFormTransaksi.overbooking_transaction.value;
    bool condition = true;
    if (overBooking == false) {
      condition = cListProduct.hasErros();
    } else {
      condition = cFormTransaksi.hasErros();
    }
    if (!cFormTransaksi.hasErros() && !condition) {
      int paymentterms_transaction = 0;
      DateTime tanggalTransaction =
          DateTime.parse(cFormTransaksi.tanggal_transaction.value);
      DateTime expiredTransaction =
          DateTime.parse(cFormTransaksi.expired_transaction.value);
      if (tanggalTransaction != null && expiredTransaction != null) {
        paymentterms_transaction =
            expiredTransaction.difference(tanggalTransaction).inDays;
      }

      final overBooking = cFormTransaksi.overbooking_transaction.value;

      int totalproduct_transaction = 0;
      num subtotal_transaction = 0;
      num totalprice_transaction = 0;

      var products_id = '';
      var qty_detail = '';
      var price_detail = '';
      var subtotal_detail = '';
      var remarks_detail = '';
      var matauang_detail = '';
      var kurs_detail = '';
      if (!overBooking!) {
        totalproduct_transaction = cListProduct.getListProduct
            .map((item) => item['qty_detail'] as int)
            .reduce((value, element) => value + element);
        subtotal_transaction = cListProduct.getListProduct
            .map((item) => item['price_detail'])
            .reduce((value, element) => value + element);
        totalprice_transaction = cListProduct.getListProduct
            .map((item) => item['subtotal_detail'])
            .reduce((value, element) => value + element);

        products_id = jsonEncode(cListProduct.getListProduct
            .map((item) => item['products_id'])
            .toList());
        qty_detail = jsonEncode(cListProduct.getListProduct
            .map((item) => item['qty_detail'])
            .toList());
        price_detail = jsonEncode(cListProduct.getListProduct
            .map((item) => item['price_detail'])
            .toList());
        subtotal_detail = jsonEncode(cListProduct.getListProduct
            .map((item) => item['subtotal_detail'])
            .toList());
        remarks_detail = jsonEncode(cListProduct.getListProduct
            .map((item) => item['remarks_detail'])
            .toList());
        matauang_detail = jsonEncode(cListProduct.getListProduct
            .map((item) => item['matauang_detail'])
            .toList());
        kurs_detail = jsonEncode(cListProduct.getListProduct
            .map((item) => item['kurs_detail'])
            .toList());
      } else {
        totalproduct_transaction = 1;
        subtotal_transaction = num.parse(cOverBooking.nominal_booking.value);
        totalprice_transaction = num.parse(cOverBooking.nominal_booking.value);
      }

      bool? isPPnTransaction = cFormTransaksi.isppn_transaction.value;
      num valuePPnTransaction = (cFormTransaksi.valueppn_transaction.value);

      num totalppn_transaction = cFormTransaksi.isppn_transaction.value == true
          ? totalprice_transaction * valuePPnTransaction / 100
          : 0;

      if (isPPnTransaction == true) {
        totalprice_transaction = totalprice_transaction + totalppn_transaction;
      }

      FormTransaksi transaksi = FormTransaksi(
        code_transaction: cFormTransaksi.code_transaction.value,
        tanggal_transaction: (cFormTransaksi.tanggal_transaction.value),
        paidto_transaction: cFormTransaksi.paidto_transaction.value,
        metode_pembayaran_id:
            int.parse(cFormTransaksi.metode_pembayaran_id.value),
        expired_transaction: (cFormTransaksi.expired_transaction.value),
        purpose_transaction: cFormTransaksi.purpose_transaction.value,
        purposedivisi_transaction:
            cFormTransaksi.purposedivisi_transaction.value,
        isppn_transaction:
            cFormTransaksi.isppn_transaction.value == true ? 1 : 0,
        valueppn_transaction: cFormTransaksi.valueppn_transaction.value,
        paymentterms_transaction: paymentterms_transaction,
        totalproduct_transaction: totalproduct_transaction,
        totalprice_transaction: totalprice_transaction,
        overbooking_transaction:
            cFormTransaksi.overbooking_transaction.value == true ? 1 : 0,
        totalppn_transaction: totalppn_transaction,
        subtotal_transaction: subtotal_transaction,
        attachment_transaction: cFormTransaksi.attachment_transaction,
        nomorvirtual_transaction: cFormTransaksi.nomorvirtual_transaction.value,
        accept_transaction: cFormTransaksi.accept_transaction.value,
        bank_transaction: cFormTransaksi.bank_transaction.value,
        products_id: products_id,
        qty_detail: qty_detail,
        price_detail: price_detail,
        subtotal_detail: subtotal_detail,
        remarks_detail: remarks_detail,
        matauang_detail: matauang_detail,
        kurs_detail: kurs_detail,
        jenis_over_booking: cOverBooking.jenis_over_booking.value,
        darirekening_booking: cOverBooking.darirekening_booking.value,
        pemilikrekening_booking: cOverBooking.pemilikrekening_booking.value,
        tujuanrekening_booking: cOverBooking.tujuanrekening_booking.value,
        pemiliktujuan_booking: cOverBooking.pemiliktujuan_booking.value,
        nominal_booking: cOverBooking.nominal_booking.value,
      );
      if (!cFormTransaksi.is_edit.value) {
        cFormTransaksi.postTransaksi(transaksi.convertoFormData());
      } else {
        cFormTransaksi.updateTransaksi(transaksi.convertoFormData());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        cSearchProduct.setFocused(true);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    cFormTransaksi.resetForm();
    cListProduct.resetForm();
    cOverBooking.resetForm();
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
          'Form Pengajuan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<CFormTransaksi>(
          init: CFormTransaksi(),
          builder: (controller) {
            if (controller.metodePembayaranList.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Stepper(
              type: StepperType.horizontal,
              currentStep: currentStep,
              onStepTapped: (step) {
                setState(() {
                  currentStep = step;
                });
              },
              onStepContinue: () {
                setState(() {
                  if (currentStep < 1) {
                    currentStep += 1;
                  }
                });
              },
              onStepCancel: () {
                setState(() {
                  if (currentStep > 0) {
                    currentStep -= 1;
                  }
                });
              },
              steps: [
                Step(
                  title: const TextMain(
                    text: 'Pengajuan',
                    size: 12,
                  ),
                  content: Step1(context, controller),
                  isActive: currentStep == 0,
                ),
                if (controller.overbooking_transaction.value == false)
                  Step(
                    title: const TextMain(
                      text: 'Product',
                      size: 12,
                    ),
                    content: Step2(context),
                    isActive: currentStep == 1,
                  ),
                if (controller.overbooking_transaction.value == true)
                  Step(
                    title: const TextMain(
                      text: 'Over Booking',
                      size: 12,
                    ),
                    content: Step3(
                        cListProduct: cListProduct,
                        cFormTransaksi: cFormTransaksi),
                    isActive: currentStep == 1,
                  ),
              ],
              controlsBuilder: (context, details) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      if (currentStep > 0)
                        Expanded(
                          child: ButtonPrimary(
                            label: 'Sebelumnya',
                            onTap: details.onStepCancel,
                            color: AppColor.errorColor,
                          ),
                        ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ButtonPrimary(
                          label: currentStep == 0 ? 'Selanjutnya' : 'Submit',
                          onTap: currentStep == 0
                              ? details.onStepContinue
                              : onSubmit,
                          color: AppColor.secondary,
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }),
    );
  }

  Column Step2(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchData(
          hintText: 'Cari Product...',
          focusNode: _focusNode,
          onChanged: cSearchProduct.setSearchProductText,
        ),
        GetBuilder<CSearchProduct>(
            init: CSearchProduct(),
            builder: (controller) {
              final isFocused = controller.isFocused.value;
              if (isFocused) {
                if (controller.isLoading.value &&
                    controller.semuaProduct.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (!controller.isLoading.value &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          controller.fetchProduksi(
                              controller.searchProductText.value,
                              onSearch: false);
                          return true;
                        }
                        return false;
                      },
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  controller.setFocused(false);
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 150,
                            child: ListView.builder(
                              itemCount: controller.semuaProduct.length + 1,
                              itemBuilder: (context, index) {
                                if (index < controller.semuaProduct.length) {
                                  final dataProduct =
                                      controller.semuaProduct[index];

                                  return ListTile(
                                    onTap: () {
                                      cListProduct.setListProduct(dataProduct);
                                    },
                                    title: TextMain(
                                      text:
                                          '[${dataProduct['code_product']}] ${dataProduct['name_product']}',
                                      textFontWeight: FontWeight.bold,
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextMain(
                                            text: dataProduct[
                                                'capacity_product']),
                                        TextMain(
                                            text: dataProduct[
                                                'specification_product']),
                                      ],
                                    ),
                                  );
                                } else {
                                  if (controller.hasMoreData.value) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      ));
                }
              }
              return const SizedBox();
            }),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          color: AppColor.borderColor,
          thickness: 0.2,
        ),
        GetBuilder<CListProduct>(
            init: CListProduct(),
            builder: (controller) {
              return SizedBox(
                height: 400,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    reverse: true,
                    itemCount: controller.getListProduct.length,
                    itemBuilder: (context, index) {
                      final dataListProduct = controller.getListProduct[index];

                      List<dynamic> mataUangList =
                          cListProduct.getListDataStatic['mataUang'];
                      List<dynamic> namaMetodePembayaran = mataUangList
                          .map((item) => item['nama_datastatis'])
                          .toList();

                      return Card(
                        key: ValueKey(index),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextMain(
                                        text:
                                            '[${dataListProduct['code_product']}]',
                                        textFontWeight: FontWeight.bold,
                                      ),
                                      TextMain(
                                        text:
                                            '${dataListProduct['name_product']}',
                                        textFontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      TextMain(
                                        text:
                                            dataListProduct['capacity_product'],
                                        textFontWeight: FontWeight.bold,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            cListProduct.removeListProduct(
                                                dataListProduct);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: AppColor.errorColor,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: TextInputWithLabel(
                                      label: 'Remarks',
                                      controller: controller
                                          .remarks_detail_controller[index],
                                      onChanged: (value) =>
                                          controller.updateListProduct(
                                              value,
                                              dataListProduct,
                                              'remarks_detail'),
                                      isError:
                                          controller.productListError[index]
                                              ['remarks_detail'],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextInputWithLabel(
                                      label: 'Qty',
                                      controller: controller
                                          .qty_detail_controller[index],
                                      textInputFormatter: _formatter,
                                      typeTextInputType: TextInputType.number,
                                      onChanged: (value) =>
                                          controller.updateListProduct(value,
                                              dataListProduct, 'qty_detail'),
                                      isError:
                                          controller.productListError[index]
                                              ['qty_detail'],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: TextInputWithLabel(
                                    label: 'Harga',
                                    controller: controller
                                        .price_detail_controller[index],
                                    typeTextInputType: TextInputType.number,
                                    textInputFormatter: _formatter,
                                    onChanged: (value) =>
                                        controller.updateListProduct(value,
                                            dataListProduct, 'price_detail'),
                                    isError: controller.productListError[index]
                                        ['price_detail'],
                                  )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextInputWithLabel(
                                      typeTextInputType: TextInputType.number,
                                      label: 'Sub Total',
                                      controller: TextEditingController(
                                          text: NumberTextInputFormatter()
                                              .addThousandSeparator(
                                                  dataListProduct[
                                                          'subtotal_detail']
                                                      .toString())),
                                      readOnly: true,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              DropdownMenu(
                                label: const TextMain(text: 'Mata Uang'),
                                initialSelection:
                                    dataListProduct['matauang_detail'],
                                onSelected: (value) =>
                                    controller.updateListProduct(value,
                                        dataListProduct, 'matauang_detail'),
                                width: MediaQuery.of(context).size.width - 90,
                                dropdownMenuEntries:
                                    namaMetodePembayaran.map((item) {
                                  return DropdownMenuEntry<String>(
                                    label: item,
                                    value: item,
                                  );
                                }).toList(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextInputWithLabel(
                                typeTextInputType: TextInputType.number,
                                label: 'Kurs Detail',
                                controller:
                                    controller.kurs_detail_controller[index],
                                onChanged: (value) =>
                                    controller.updateListProduct(
                                        value, dataListProduct, 'kurs_detail'),
                                isError: controller.productListError[index]
                                    ['kurs_detail'],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              );
            }),
      ],
    );
  }

  SingleChildScrollView Step1(BuildContext context, CFormTransaksi controller) {
    List<dynamic> metodePembayaranList =
        controller.metodePembayaranList.value['metodePembayaran'];

    final metodePembayaranId = controller.metode_pembayaran_id.value;
    dynamic findPembayaran = metodePembayaranList.firstWhere(
      (metode) => metode['id'].toString() == metodePembayaranId,
    );

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const TitleAndSubtitle(
            title: 'Form Pengajuan',
            description: 'Isi Beberapa field dibawah ini\ndengan benar yah',
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  return Expanded(
                    child: TextInputWithLabel(
                      label: 'Code',
                      onChanged: controller.setCodeTransaction,
                      isError: controller.errorMessages['code_transaction'],
                      controller: controller.code_transaction_controller,
                    ),
                  );
                }),
                const SizedBox(
                  width: 10,
                ),
                Obx(() => Expanded(
                      child: TextInputWithLabel(
                        controller: controller.tanggal_transaction_controller,
                        label: 'Tanggal Pengajuan',
                        readOnly: true,
                        suffixIcon: Icons.calendar_today,
                        onTap: () => _selectDate(context),
                        onChanged: controller.setTanggalTransaction,
                        isError:
                            controller.errorMessages['tanggal_transaction'],
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextInputWithLabel(
              label: 'Dibayarkan Kepada',
              onChanged: controller.setPaidToTransaction,
              controller: controller.paidto_transaction_controller,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownMenu(
              initialSelection: controller.metode_pembayaran_id.value,
              onSelected: controller.setMetodePembayaranId,
              width: MediaQuery.of(context).size.width - 80,
              dropdownMenuEntries: metodePembayaranList.map((item) {
                return DropdownMenuEntry<String>(
                  label: item['nama_metode_pembayaran'],
                  value: item['id'].toString(),
                );
              }).toList(),
            ),
          ),
          Obx(() {
            if (controller.errorMessages['metode_pembayaran_id'] != null &&
                controller.errorMessages['metode_pembayaran_id'] != '') {
              return TextMain(
                  text: controller.errorMessages['metode_pembayaran_id']!,
                  size: 12,
                  textColor: AppColor.errorColor,
                  textFontWeight: FontWeight.w400);
            }
            return Container();
          }),
          const SizedBox(
            height: 15,
          ),
          if (findPembayaran['nama_metode_pembayaran'] == 'Transfer')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextInputWithLabel(
                      label: 'Rekening Penerima',
                      onChanged: controller.setAcceptTransaction,
                      controller: controller.accept_transaction_controller,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextInputWithLabel(
                      label: 'Bank Penerima',
                      onChanged: controller.setBankTransaction,
                      controller: controller.bank_transaction_controller,
                    ),
                  ),
                ],
              ),
            ),
          if (findPembayaran['nama_metode_pembayaran'] == 'Virtual Account')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextInputWithLabel(
                        label: 'Nomor Virtual Account',
                        onChanged: controller.setNomorVirtualTransaction,
                        controller:
                            controller.nomorvirtual_transaction_controller),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextInputWithLabel(
                      label: 'Bank Penerima',
                      onChanged: controller.setBankTransaction,
                      controller: controller.bank_transaction_controller,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(
            height: 15,
          ),
          Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextInputWithLabel(
                  controller: controller.expired_transaction_controller,
                  label: 'Tanggal Expired',
                  readOnly: true,
                  suffixIcon: Icons.calendar_today,
                  onTap: () => _selectDateExpired(context),
                  onChanged: controller.setExpiredTransaction,
                  isError: controller.errorMessages['expired_transaction'],
                ),
              )),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Expanded(
                      child: TextInputWithLabel(
                        label: 'Tujuan Transaksi',
                        onChanged: controller.setPuposeTransaction,
                        isError:
                            controller.errorMessages['purpose_transaction'],
                        controller: controller.purpose_transaction_controller,
                      ),
                    )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextInputWithLabel(
                    label: 'Purpose (Divisi)',
                    onChanged: controller.setPurposeDivisiTransaction,
                    controller: controller.purposedivisi_transaction_controller,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Checkbox(
                            checkColor: Colors.white,
                            value: controller.isppn_transaction.value,
                            onChanged: controller.setIsPpnTransaction),
                        const TextMain(
                          text: 'PPN ?',
                          size: 12,
                        ),
                      ]),
                      const SizedBox(
                        width: 20,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            value: controller.overbooking_transaction.value,
                            onChanged: controller.setOverbookingTransaction,
                          ),
                          const TextMain(
                            text: 'Overbooking ?',
                            size: 12,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextInputWithLabel(
                    label: 'Persen (%) PPN',
                    controller: controller.valueppn_transaction_controller,
                    readOnly: controller.isppn_transaction.value == false,
                    onChanged: (value) => controller.setValuePpnTransaction(
                        value != null && value != '' ? num.parse(value) : 0),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColor.secondary,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(16),
                      ),
                      onPressed: _pickFile,
                      child: const Row(
                        children: [
                          Icon(Icons.upload),
                          TextMain(
                            text: 'Upload File',
                            textColor: Colors.white,
                            textFontWeight: FontWeight.w600,
                          ),
                        ],
                      )),
                  const SizedBox(
                    width: 15,
                  ),
                  if (controller.attachment_transaction.path.isNotEmpty)
                    Flexible(
                      child: Wrap(children: [
                        Text(
                            'File terpilih: ${controller.attachment_transaction.path}')
                      ]),
                    ),
                ],
              )),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

class Step3 extends StatelessWidget {
  Step3({super.key, required this.cListProduct, required this.cFormTransaksi});

  CListProduct cListProduct;
  CFormTransaksi cFormTransaksi;
  TextInputFormatter _formatter = NumberTextInputFormatter();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<COverBooking>(
        init: COverBooking(),
        builder: (controller) {
          if (cListProduct.getListDataStatic['jenisOverBooking'] == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<dynamic> dataJenisOverBooking =
              cListProduct.getListDataStatic['jenisOverBooking'];

          return Column(
            children: [
              DropdownMenu(
                initialSelection: controller.jenis_over_booking.value,
                onSelected: (value) => controller.setJenisOverBooking(value),
                width: MediaQuery.of(context).size.width - 50,
                dropdownMenuEntries: dataJenisOverBooking.map((item) {
                  return DropdownMenuEntry(
                    label: item,
                    value: item,
                  );
                }).toList(),
              ),
              Obx(() {
                if (cFormTransaksi.errorMessages['jenis_over_booking'] !=
                        null &&
                    cFormTransaksi.errorMessages['jenis_over_booking'] != '') {
                  return TextMain(
                      text: cFormTransaksi.errorMessages['jenis_over_booking']!,
                      size: 12,
                      textColor: AppColor.errorColor,
                      textFontWeight: FontWeight.w400);
                }
                return Container();
              }),
              const SizedBox(
                height: 10,
              ),
              Obx(() => TextInputWithLabel(
                    label: 'Dari Nomor Rekening',
                    onChanged: controller.setDariRekeningBooking,
                    typeTextInputType: TextInputType.number,
                    isError:
                        cFormTransaksi.errorMessages['darirekening_booking'],
                    controller: controller.darirekening_booking_controller,
                  )),
              const SizedBox(
                height: 10,
              ),
              Obx(() => TextInputWithLabel(
                  label: 'Nama Pemilik Rekening',
                  onChanged: controller.setPemilikRekening,
                  controller: controller.pemilikrekening_booking_controller,
                  isError:
                      cFormTransaksi.errorMessages['pemilikrekening_booking'])),
              const SizedBox(
                height: 10,
              ),
              Obx(() => TextInputWithLabel(
                  label: 'Nomor Rekening Tujuan',
                  onChanged: controller.setTujuanRekening,
                  controller: controller.tujuanrekening_booking_controller,
                  typeTextInputType: TextInputType.number,
                  isError:
                      cFormTransaksi.errorMessages['tujuanrekening_booking'])),
              const SizedBox(
                height: 10,
              ),
              Obx(() => TextInputWithLabel(
                  label: 'Nama Pemilik Rekening',
                  onChanged: controller.setPemilikTujuan,
                  controller: controller.pemiliktujuan_booking_controller,
                  isError:
                      cFormTransaksi.errorMessages['pemiliktujuan_booking'])),
              const SizedBox(
                height: 10,
              ),
              Obx(() => TextInputWithLabel(
                  label: 'Nominal Booking',
                  onChanged: controller.setNominalBooking,
                  controller: controller.nominal_booking_controller,
                  typeTextInputType: TextInputType.number,
                  textInputFormatter: _formatter,
                  isError: cFormTransaksi.errorMessages['nominal_booking'])),
            ],
          );
        });
  }
}
