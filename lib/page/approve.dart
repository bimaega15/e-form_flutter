import 'package:e_form/config/app_color.dart';
import 'package:e_form/config/helper.dart';
import 'package:e_form/config/number_text_formatter.dart';
import 'package:e_form/config/utils.dart';
import 'package:e_form/controller/c_pick_superior.dart';
import 'package:e_form/widget/button_primary.dart';
import 'package:e_form/widget/card_permintaan.dart';
import 'package:e_form/widget/search_data.dart';
import 'package:e_form/widget/text_input_with_label.dart';
import 'package:e_form/widget/text_main.dart';
import 'package:e_form/widget/title_and_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Approve extends StatefulWidget {
  const Approve({super.key});

  @override
  State<Approve> createState() => _ApproveState();
}

class _ApproveState extends State<Approve> {
  CPickSuperior cPickSuperior = Get.put(CPickSuperior());
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    final receivedData = Get.arguments;
    cPickSuperior.getUsersProfile(
        transactionId: receivedData['id'], search: '', onSearch: false);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        cPickSuperior.setFocused(
          true,
          receivedData['id'],
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    cPickSuperior.resetForm();
  }

  Future<void> onSubmit(int transactionId) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Obx(() => AlertDialog(
              title: const TextMain(
                text: 'Submit Confirmation',
                textFontWeight: FontWeight.bold,
                size: 24,
              ),
              content:
                  const Text('Apakah anda yakin ingin approvel data ini?\n'),
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
                  child: cPickSuperior.isLoadingSubmit.value
                      ? const CircularProgressIndicator()
                      : const Text('Submit'),
                  onPressed: () {
                    if (!cPickSuperior.hasErros()) {
                      cPickSuperior.submitData(transactionId);
                    }
                    if (!cPickSuperior.isLoadingSubmit.value) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ));
      },
    );
  }

  void onFinish(Map<dynamic, dynamic> data) {
    if (!cPickSuperior.hasErrorFinish()) {
      cPickSuperior.finishData(data);
    }
  }

  Future<void> onDialogConfirm(
      {String textConfirm = '',
      String type = '',
      int transactionId = 0}) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Obx(() => AlertDialog(
              title: const TextMain(
                text: 'Submit Confirmation',
                textFontWeight: FontWeight.bold,
                size: 20,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                        color: AppColor.darkText,
                        fontSize: 16,
                      )),
                      children: [
                        const TextSpan(
                          text: 'Apakah anda yakin ingin ',
                        ),
                        TextSpan(
                          text: textConfirm,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        const TextSpan(text: ' Form pengajuan ini?'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextInputWithLabel(
                    label: 'Keterangan',
                    typeTextInputType: TextInputType.multiline,
                    maxLines: 6,
                    onChanged: cPickSuperior.setKeteranganApprovel,
                    isError: cPickSuperior.errorMessages['keterangan_approvel'],
                  ),
                ],
              ),
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
                  child: cPickSuperior.isLoadingSubmit.value
                      ? const CircularProgressIndicator()
                      : const Text('Submit'),
                  onPressed: () {
                    onFinish({
                      'transaction_id': transactionId,
                      'type': type,
                      'keterangan_approvel':
                          cPickSuperior.keterangan_approvel.value,
                    });
                    if (!cPickSuperior.isLoadingSubmit.value &&
                        !cPickSuperior.hasErrorFinish()) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ));
      },
    );
  }

  Future<void> onDialogDetailInfo(receivedData) async {
    final overbooking_transaction = receivedData['overbooking_transaction'];
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const TextMain(
            text: 'Information Detail',
            textFontWeight: FontWeight.bold,
            size: 20,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (overbooking_transaction == 1)
                  OverbookingAccount(receivedData),
                SizedBox(
                  width: double.maxFinite,
                  height: 400,
                  child: ListView.builder(
                    itemCount: receivedData['products']
                        .length, // Ganti dengan jumlah item yang sesuai
                    itemBuilder: (BuildContext context, int index) {
                      final item = receivedData['products'][index];
                      return CardPermintaan(
                        nameProduct: item['name'],
                        qtyProduct: item['qty'].toString(),
                        priceProduct: item['price'],
                        subTotalProduct: item['subTotal'],
                        descriptionProduct: item['remarks'],
                        currencyProduct: item['currency'],
                        currenctCurs: item['curs'].toString(),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Column OverbookingAccount(receivedData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Center(
          child: TextMain(
            text: 'Overbooking Account',
            textAlign: TextAlign.center,
            textFontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const TextMain(
          textAlign: TextAlign.left,
          text: 'Jenis Overbooking',
          textColor: AppColor.greyColor,
          size: 12,
        ),
        TextMain(
          textAlign: TextAlign.left,
          text: receivedData['over_booking']['jenis_over_booking'],
          textColor: AppColor.darkText,
          size: 14,
        ),
        const SizedBox(
          height: 10,
        ),
        const TextMain(
          textAlign: TextAlign.left,
          text: 'Dari No.Rek',
          textColor: AppColor.greyColor,
          size: 12,
        ),
        TextMain(
          textAlign: TextAlign.left,
          text: receivedData['over_booking']['darirekening_booking'],
          textColor: AppColor.darkText,
          size: 14,
        ),
        const SizedBox(
          height: 10,
        ),
        const TextMain(
          textAlign: TextAlign.left,
          text: 'Nama Pemilik',
          textColor: AppColor.greyColor,
          size: 12,
        ),
        TextMain(
          textAlign: TextAlign.left,
          text: receivedData['over_booking']['pemilikrekening_booking'],
          textColor: AppColor.darkText,
          size: 14,
        ),
        const SizedBox(
          height: 10,
        ),
        const TextMain(
          textAlign: TextAlign.left,
          text: 'Nomor Rek.Tujuan',
          textColor: AppColor.greyColor,
          size: 12,
        ),
        TextMain(
          textAlign: TextAlign.left,
          text: receivedData['over_booking']['tujuanrekening_booking'],
          textColor: AppColor.darkText,
          size: 14,
        ),
        const SizedBox(
          height: 10,
        ),
        const TextMain(
          textAlign: TextAlign.left,
          text: 'Nama Pemilik',
          textColor: AppColor.greyColor,
          size: 12,
        ),
        TextMain(
          textAlign: TextAlign.left,
          text: receivedData['over_booking']['pemiliktujuan_booking'],
          textColor: AppColor.darkText,
          size: 14,
        ),
        const SizedBox(
          height: 10,
        ),
        const TextMain(
          textAlign: TextAlign.left,
          text: 'Nominal',
          textColor: AppColor.greyColor,
          size: 12,
        ),
        TextMain(
          textAlign: TextAlign.left,
          text: NumberTextInputFormatter().addThousandSeparator(
              receivedData['over_booking']['nominal_booking'].toString()),
          textColor: AppColor.darkText,
          size: 14,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final receivedData = Get.arguments;
    bool isConfirmedApprovel = Helper().isConfirmedApprovel(receivedData);
    String status = receivedData['status'];

    return Scaffold(
      backgroundColor: AppColor.backgroundScaffold,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          'Approvel Pengajuan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(16),
        children: [
          Table(
            columnWidths: const {
              0: FlexColumnWidth(0.7),
              1: FlexColumnWidth(0.1),
              2: FlexColumnWidth(1),
            },
            children: [
              TableRow(children: [
                const TableCell(
                    child: TextMain(
                  text: 'Diajukan Oleh',
                )),
                const TableCell(
                    child: TextMain(
                  text: ':',
                )),
                TableCell(
                  child: InkWell(
                    onTap: () {
                      onDialogDetailInfo(receivedData);
                    },
                    child: TextMain(
                      text: receivedData['reqBy'],
                      size: 16,
                      textFontWeight: FontWeight.bold,
                      textColor: AppColor.mainText,
                    ),
                  ),
                ),
              ]),
              TableRow(children: [
                const TableCell(
                    child: TextMain(
                  text: 'Tanggal',
                )),
                const TableCell(
                    child: TextMain(
                  text: ':',
                )),
                TableCell(
                    child: TextMain(
                  text: Utils().formatDateIndo(receivedData['reqDate']),
                )),
              ]),
            ],
          ),
          if (!isConfirmedApprovel && status != 'direvisi')
            ForwardUser(receivedData),
          const SizedBox(
            height: 20,
          ),
          if (isConfirmedApprovel || status == 'direvisi')
            FormFinish(receivedData),
          const Divider(
            color: AppColor.darkText,
            thickness: 0.2,
          ),
          if (!isConfirmedApprovel && status != 'direvisi')
            ButtonConfirmed(receivedData),
        ],
      ),
    );
  }

  Column FormFinish(receivedData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleAndSubtitle(
            padding: 0,
            title: 'Konfirmasi Approvel',
            description:
                'Pilih antara 3 konfirmasi ini, mengenai \nform pengajuan ini.'),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ButtonPrimary(
                label: 'Selesaikan',
                color: AppColor.secondary,
                onTap: () {
                  onDialogConfirm(
                      textConfirm: 'Menyelesaikan',
                      transactionId: receivedData['id'],
                      type: 'disetujui');
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ButtonPrimary(
                label: 'Tolak',
                color: AppColor.errorColor,
                onTap: () {
                  onDialogConfirm(
                      textConfirm: 'Menolak',
                      transactionId: receivedData['id'],
                      type: 'ditolak');
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ButtonPrimary(
                label: 'Revisi',
                color: AppColor.mainText,
                onTap: () {
                  onDialogConfirm(
                      textConfirm: 'Merevisi',
                      transactionId: receivedData['id'],
                      type: 'direvisi');
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Row ButtonConfirmed(receivedData) {
    return Row(children: [
      Expanded(
        child: ButtonPrimary(
          label: 'Batal',
          color: AppColor.errorColor,
          onTap: () {
            Get.back();
          },
        ),
      ),
      const SizedBox(
        width: 15,
      ),
      Expanded(
        child: ButtonPrimary(
          label: 'Submit',
          color: AppColor.secondary,
          onTap: () {
            onSubmit(receivedData['id']);
          },
        ),
      ),
    ]);
  }

  Column ForwardUser(receivedData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        SearchData(
          hintText: 'Diteruskan Oleh',
          focusNode: _focusNode,
          controller: cPickSuperior.forwardUsers,
          onChanged: (value) =>
              cPickSuperior.searchUsersProfile(value, receivedData['id']),
        ),
        Obx(() {
          if (cPickSuperior.errorMessages['users_id_forward'] != null) {
            return TextMain(
                text: cPickSuperior.errorMessages['users_id_forward']!,
                size: 12,
                textColor: AppColor.errorColor,
                textFontWeight: FontWeight.w400);
          }
          return Container();
        }),
        GetBuilder<CPickSuperior>(
            init: CPickSuperior(),
            builder: (controller) {
              final isFocused = controller.isFocused.value;
              if (isFocused) {
                if (controller.isLoading.value &&
                    controller.getSuperior.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (!controller.isLoading.value &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          controller.getUsersProfile(
                              onSearch: false,
                              transactionId: receivedData['id'],
                              search: controller.searchText.value);
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
                                  controller.setFocused(
                                      false, receivedData['id']);
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                              itemCount: controller.getSuperior.length + 1,
                              itemBuilder: (context, index) {
                                if (index < controller.getSuperior.length) {
                                  final dataSuperior =
                                      controller.getSuperior[index];

                                  return ListTile(
                                    onTap: () {
                                      controller.pickSuperior(dataSuperior);
                                    },
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextMain(
                                          text: dataSuperior['text'],
                                          textFontWeight: FontWeight.w400,
                                        ),
                                        const Divider(
                                          color: AppColor.darkText,
                                          thickness: 0.2,
                                        ),
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
        const SizedBox(height: 20),
        Obx(() => TextInputWithLabel(
              label: 'Keterangan',
              typeTextInputType: TextInputType.multiline,
              maxLines: 6,
              onChanged: cPickSuperior.setKeteranganApprovel,
              isError: cPickSuperior.errorMessages['keterangan_approvel'],
            )),
        const SizedBox(height: 20),
      ],
    );
  }
}
