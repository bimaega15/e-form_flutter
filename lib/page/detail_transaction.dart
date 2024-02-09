// ignore_for_file: deprecated_member_use

import 'package:e_form/config/app_color.dart';
import 'package:e_form/config/utils.dart';
import 'package:e_form/widget/card_approvel.dart';
import 'package:e_form/widget/card_permintaan.dart';
import 'package:e_form/widget/detail_transaksi.dart';
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Map<dynamic, dynamic> receivedData = Get.arguments;

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
          PopupMenuButton(
            onSelected: (value) {
              // Handle a menu item click
              if (value == 'edit') {
                // Implement edit action
              } else if (value == 'delete') {
                // Implement delete action
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ];
            },
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
                }),
          if (current == 2) detailHistoryApprovel(),
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
                return CardApprovel(
                    profileApprovel: dataApprovel['profileApprovel'],
                    nameApprovel: dataApprovel['requestPeople'],
                    statusApprovel: Utils()
                        .capitalizeEachWord(dataApprovel['statusTransaction']),
                    diteruskanApprovel:
                        'Diteruskan oleh ${dataApprovel['forwardPeople']} [${dataApprovel['forwardJabatan']}]',
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
