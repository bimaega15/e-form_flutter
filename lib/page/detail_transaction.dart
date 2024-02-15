// ignore_for_file: deprecated_member_use

import 'package:e_form/config/app_color.dart';
import 'package:e_form/config/app_route.dart';
import 'package:e_form/config/helper.dart';
import 'package:e_form/config/number_text_formatter.dart';
import 'package:e_form/config/utils.dart';
import 'package:e_form/controller/c_auth.dart';
import 'package:e_form/controller/c_form_transaksi.dart';
import 'package:e_form/controller/c_profile.dart';
import 'package:e_form/widget/card_approvel.dart';
import 'package:e_form/widget/card_permintaan.dart';
import 'package:e_form/widget/data_transaksi.dart';
import 'package:e_form/widget/detail_transaksi.dart';
import 'package:e_form/widget/text_main.dart';
import 'package:e_form/widget/title_and_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailTransaction extends StatefulWidget {
  const DetailTransaction({super.key});

  @override
  State<DetailTransaction> createState() => _DetailTransactionState();
}

class _DetailTransactionState extends State<DetailTransaction> {
  CFormTransaksi cFormTransaksi = Get.put(CFormTransaksi());
  CProfile cProfile = Get.put(CProfile());
  CAuth cAuth = Get.put(CAuth());
  final List<String> menuTabBar = [
    'Detail Transaksi',
    'Permintaan',
    'History Approval',
  ];

  int current = 0;

  double changePositionedOfLine() {
    switch (current) {
      case 0:
        return 6;
      case 1:
        return 117;
      case 2:
        return 204;
      default:
        return 0;
    }
  }

  double changeContainerWidth() {
    switch (current) {
      case 0:
        return 70;
      case 1:
        return 50;
      case 2:
        return 75;
      default:
        return 0;
    }
  }

  Future<void> onDelete(id) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Obx(() => AlertDialog(
              title: const TextMain(
                text: 'Delete Confirmation',
                textFontWeight: FontWeight.bold,
                size: 24,
              ),
              content:
                  const Text('Apakah anda yaking ingin menghapus data ini?'),
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
                  child: cFormTransaksi.isLoadingDelete.value
                      ? const CircularProgressIndicator()
                      : const Text('Submit'),
                  onPressed: () {
                    cFormTransaksi.deleteForm(id);
                    if (!cFormTransaksi.isLoadingDelete.value) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ));
      },
    );
  }

  Future<void> onEdit(id) async {
    cFormTransaksi.editForm(id);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final receivedData = Get.arguments;
    final overBooking = receivedData['over_booking'] ?? '';
    final isApprove = Helper().isApprove(receivedData);
    List<dynamic> transactionApprovelLength =
        receivedData['transaction_approvel'];
    bool isDelete = transactionApprovelLength.isEmpty;
    final status = receivedData['status'];
    bool isEdit = transactionApprovelLength.isEmpty || status == 'direvisi';

    return Scaffold(
      backgroundColor: AppColor.backgroundScaffold,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          'Detail Pengajuan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Visibility(
            visible: isEdit || isDelete || isApprove,
            child: PopupMenuButton(
              onSelected: (value) {
                // Handle a menu item click
                if (value == 'edit') {
                  onEdit(receivedData['id']);
                } else if (value == 'delete') {
                  onDelete(receivedData['id']);
                } else if (value == 'approve') {
                  Get.toNamed(AppRoute.approve, arguments: receivedData);
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  if (isEdit)
                    const PopupMenuItem<String>(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                  if (isDelete)
                    const PopupMenuItem<String>(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  if (isApprove)
                    const PopupMenuItem<String>(
                      value: 'approve',
                      child: Text('Approve Pengajuan'),
                    ),
                ];
              },
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          const TitleAndSubtitle(
            title: 'Data Pengajuan',
            description: 'Berikut isi detail dari data pengajuan',
          ),
          const SizedBox(height: 20),
          titleTabBar(size),
          const SizedBox(height: 10),
          if (current == 0)
            DetailTransaksi(
              receivedData: receivedData,
            ),
          if (current == 1)
            Column(
              children: [
                if (receivedData['overbooking_transaction'] == 1)
                  OverBookingTransactionView(overBooking),
                if (receivedData['overbooking_transaction'] != 1)
                  ListView.builder(
                      itemCount: receivedData['products'].length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = receivedData['products'][index];
                        return CardPermintaan(
                          nameProduct: item['name'],
                          qtyProduct: item['qty'].toString(),
                          priceProduct: item['price'],
                          subTotalProduct: item['subTotal'],
                          descriptionProduct: item['remarks'],
                          currencyProduct: item['currency'],
                          currenctCurs: item['curs'].toString(),
                          totalProduct: item['totalPrice'],
                        );
                      })
              ],
            ),
          if (current == 2) detailHistoryApprovel(),
        ],
      ),
    );
  }

  Padding OverBookingTransactionView(Map<dynamic, dynamic> overBooking) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DataTransaksi(
            titleLeft: 'Jenis Over Booking',
            answerLeft: overBooking['jenis_over_booking'],
          ),
          const Divider(
            color: AppColor.borderColor,
            thickness: 0.2,
          ),
          DataTransaksi(
            titleLeft: 'Dari Rekening',
            answerLeft: overBooking['darirekening_booking'],
            titleRight: 'Pemilik Rekening',
            answerRight: overBooking['pemilikrekening_booking'],
          ),
          const Divider(
            color: AppColor.borderColor,
            thickness: 0.2,
          ),
          DataTransaksi(
            titleLeft: 'Tujuan Rekening',
            answerLeft: overBooking['tujuanrekening_booking'],
            titleRight: 'Pemilik Tujuan',
            answerRight: overBooking['pemiliktujuan_booking'],
          ),
          const Divider(
            color: AppColor.borderColor,
            thickness: 0.2,
          ),
          DataTransaksi(
            titleLeft: 'Nominal',
            answerLeft: NumberTextInputFormatter().addThousandSeparator(
                overBooking['nominal_booking'].toString()),
          ),
          const Divider(
            color: AppColor.borderColor,
            thickness: 0.2,
          ),
        ],
      ),
    );
  }

  Padding detailHistoryApprovel() {
    Map<dynamic, dynamic> receivedData = Get.arguments;
    final usersApprovel = receivedData['users_approval'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleAndSubtitle(
            title: 'History Pengajuan',
            description: 'Berikut tracking form pengajuan anda:',
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
              itemCount: usersApprovel.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                bool lastData = index == usersApprovel.length - 1;
                final dataApprovel = usersApprovel[index];
                final forwardPeople = dataApprovel['forwardPeople'];
                final forwardJabatan = dataApprovel['forwardJabatan'];
                bool forwardRequest =
                    forwardPeople != null && forwardJabatan != null;
                return CardApprovel(
                    profileApprovel: dataApprovel['profileApprovel'],
                    nameApprovel: dataApprovel['requestPeople'],
                    statusApprovel: Utils()
                        .capitalizeEachWord(dataApprovel['statusTransaction']),
                    diteruskanApprovel: forwardRequest
                        ? 'Diteruskan oleh ${dataApprovel['forwardPeople']} [${dataApprovel['forwardJabatan']}]'
                        : '',
                    deskripsiApprovel: dataApprovel['keteranganApprovel'],
                    lastData: lastData);
              }),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  Padding titleTabBar(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: size.width,
        height: size.height * 0.05,
        decoration:
            const BoxDecoration(color: AppColor.backgroundCard, boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            offset: Offset(0, 2),
          )
        ]),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                width: size.width,
                height: size.height * 0.04,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: menuTabBar.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            current = index;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: index == 0 ? 16 : 22,
                              top: 4,
                              right: menuTabBar.length - 1 == index ? 22 : 0),
                          child: Text(
                            menuTabBar[index],
                            style: GoogleFonts.openSans(
                              fontSize: current == index ? 14 : 12,
                              fontWeight: current == index
                                  ? FontWeight.w400
                                  : FontWeight.w300,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            AnimatedPositioned(
              curve: Curves.fastLinearToSlowEaseIn,
              bottom: 0,
              left: changePositionedOfLine(),
              duration: const Duration(milliseconds: 500),
              child: AnimatedContainer(
                margin: const EdgeInsets.only(left: 10),
                width: changeContainerWidth(),
                height: size.height * 0.005,
                decoration: BoxDecoration(
                  color: AppColor.secondary,
                  borderRadius: BorderRadius.circular(5),
                ),
                duration: const Duration(milliseconds: 1000),
                curve: Curves.fastLinearToSlowEaseIn,
              ),
            )
          ],
        ),
      ),
    );
  }
}
