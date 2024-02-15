// ignore_for_file: unnecessary_new, prefer_typing_uninitialized_variables

import 'package:e_form/config/api_service.dart';
import 'package:e_form/config/app_color.dart';
import 'package:e_form/config/utils.dart';
import 'package:e_form/controller/c_auth.dart';
import 'package:e_form/controller/c_dashboard.dart';
import 'package:e_form/controller/c_menubar.dart';
import 'package:e_form/controller/c_profile.dart';
import 'package:e_form/dummy/dummyHome.dart';
import 'package:e_form/widget/list_transaction.dart';
import 'package:e_form/widget/title_and_subtitle.dart';
import 'package:e_form/widget/title_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Utils utils = new Utils();
  final cAuth = Get.put(CAuth());
  final cProfile = Get.put(CProfile());
  final cDashboard = Get.put(CDashboard());
  CMenuBar cMenuBar = Get.put(CMenuBar());

  @override
  void initState() {
    super.initState();
    cDashboard.getTransaksi();
    cProfile.fetchMyProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundScaffold,
      body: ListView(
        children: [
          headerMethod(),
          const SizedBox(height: 20),
          const TitleAndSubtitle(
              title: 'Pengajuan Form',
              description: 'Jumlah pengajuan yang pernah ditangani'),
          const SizedBox(height: 20),
          TitleForm(dummyList: dummyList),
          const SizedBox(height: 20),
          Flexible(
              child: TitleAndSubtitle(
            title: 'Pengajuan Terakhir',
            icon: Icons.arrow_right_alt_outlined,
            onPressedIcon: () {
              cMenuBar.indexPage = 2;
            },
          )),
          const SizedBox(height: 10),
          const Divider(
            color: AppColor.borderColor,
            thickness: 0.5,
            indent: 20,
            endIndent: 20,
          ),
          const SizedBox(height: 10),
          GetBuilder<CDashboard>(
              init: CDashboard(),
              builder: (controller) {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final myResult =
                    controller.getDashboardData.value.result['data'];

                return ListTransaction(
                  dataTransaction: myResult,
                );
              }),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Container headerMethod() {
    return Container(
      decoration: const BoxDecoration(color: AppColor.secondary, boxShadow: [
        BoxShadow(
          blurRadius: 4,
          color: Color(0x33000000),
          offset: Offset(0, 3),
        )
      ]),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: GetBuilder<CProfile>(
            init: CProfile(),
            builder: (controller) {
              final myProfile = controller.profileData.value.profile;
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi ${myProfile['name']}',
                            style: GoogleFonts.sen(
                                textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                          ),
                          Text(
                            'Buat pengajuanmu \nmenjadi lebih mudah',
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                              fontFamily: 'Open Sans',
                              color: Color(0xFFCFCDCD),
                            )),
                          ),
                        ],
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: Color(0x33000000),
                              offset: Offset(2, 2),
                              spreadRadius: 2,
                            )
                          ],
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          onTap: () {
                            cMenuBar.indexPage = 3;
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              '${ApiService.baseRoot}/upload/profile/${myProfile['profile']['gambar_profile']}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 45,
                    child: Stack(
                      children: [
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white),
                          child: TextField(
                            onChanged: cDashboard.setSearchByNoTracking,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none),
                              hintText: 'Search by no. tracking letter',
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(1, 0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Material(
                              color: const Color(0xff000000),
                              borderRadius: BorderRadius.circular(45),
                              child: InkWell(
                                onTap: () {
                                  cDashboard.onSearchTracking();
                                },
                                child: const SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: Center(
                                    child: Icon(
                                      Icons.search,
                                      color: AppColor.textColor,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    cDashboard.resetData();
    cProfile.resetMyProfile();
  }
}
