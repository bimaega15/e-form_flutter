// ignore_for_file: invalid_use_of_protected_member

import 'package:e_form/config/app_color.dart';
import 'package:e_form/config/app_route.dart';
import 'package:e_form/controller/c_dashboard.dart';
import 'package:e_form/controller/c_transaksi.dart';
import 'package:e_form/dummy/dummyHome.dart';
import 'package:e_form/widget/list_transaction_pagination.dart';
import 'package:e_form/widget/title_and_subtitle.dart';
import 'package:e_form/widget/title_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  CTransaksi cTransaksi = Get.put(CTransaksi());
  CDashboard cDashboard = Get.put(CDashboard());

  final List<String> menuTabBar = [
    'Menunggu',
    'Disetujui',
    'Ditolak',
    'Direvisi',
  ];

  int current = 0;
  bool isShowExpired = false;
  String periodeTransaction = '';

  double changePositionedOfLine() {
    switch (current) {
      case 0:
        return 6;
      case 1:
        return 89;
      case 2:
        return 160;
      case 3:
        return 221;
      default:
        return 0;
    }
  }

  double changeContainerWidth() {
    switch (current) {
      case 0:
        return 50;
      case 1:
        return 43;
      case 2:
        return 33;
      case 3:
        return 35;
      default:
        return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    cTransaksi.initialData();
    cDashboard.getTransaksi();
  }

  @override
  void dispose() {
    super.dispose();
    cTransaksi.resetData();
    cDashboard.resetData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.backgroundScaffold,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          'Riwayat Pengajuan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          const TitleAndSubtitle(
            title: 'Pengajuan Form',
            description: 'Jumlah pengajuan yang pernah ditangani',
          ),
          const SizedBox(height: 20),
          TitleForm(dummyList: dummyList),
          const SizedBox(height: 20),
          const TitleAndSubtitle(
            title: 'List History',
          ),
          const SizedBox(height: 10),
          titleTabBar(size),
          const SizedBox(height: 10),
          if (current == 0)
            GetBuilder<CTransaksi>(
                init: CTransaksi(),
                builder: (controller) {
                  if (controller.isLoadingMenunggu.value &&
                      controller.menungguList.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final myResult = controller.menungguList.value;

                    return NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (!controller.isLoadingMenunggu.value &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          controller.fetchTransakiMenunggu();
                          return true;
                        }
                        return false;
                      },
                      child: ListTransactionPagination(
                        dataTransaction: myResult,
                      ),
                    );
                  }
                }),
          if (current == 1)
            GetBuilder<CTransaksi>(
                init: CTransaksi(),
                builder: (controller) {
                  if (controller.isLoadingDisetujui.value &&
                      controller.disetujuiList.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final myResult = controller.disetujuiList.value;

                    return NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (!controller.isLoadingDisetujui.value &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          controller.fetchTransakiDisetujui();
                          return true;
                        }
                        return false;
                      },
                      child: ListTransactionPagination(
                        dataTransaction: myResult,
                      ),
                    );
                  }
                }),
          if (current == 2)
            GetBuilder<CTransaksi>(
                init: CTransaksi(),
                builder: (controller) {
                  if (controller.isLoadingDitolak.value &&
                      controller.ditolakList.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final myResult = controller.ditolakList.value;

                    return NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (!controller.isLoadingDitolak.value &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          controller.fetchTransakiDitolak();
                          return true;
                        }
                        return false;
                      },
                      child: ListTransactionPagination(
                        dataTransaction: myResult,
                      ),
                    );
                  }
                }),
          if (current == 3)
            GetBuilder<CTransaksi>(
                init: CTransaksi(),
                builder: (controller) {
                  if (controller.isLoadingDirevisi.value &&
                      controller.direvisiList.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final myResult = controller.direvisiList.value;

                    return NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (!controller.isLoadingDirevisi.value &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          controller.fetchTransakiDirevisi();
                          return true;
                        }
                        return false;
                      },
                      child: ListTransactionPagination(
                        dataTransaction: myResult,
                      ),
                    );
                  }
                }),
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
