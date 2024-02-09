import 'dart:async';

import 'package:e_form/config/app_asset.dart';
import 'package:e_form/config/app_color.dart';
import 'package:e_form/config/app_route.dart';
import 'package:e_form/widget/text_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _navigateToHome() async {
    Timer(
      const Duration(seconds: 3),
      () => Get.toNamed(AppRoute.login),
    );
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColor.backgroundScaffold,
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height * 1,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [AppColor.primary, AppColor.secondary],
          stops: [0, 1],
          begin: AlignmentDirectional(-1, -0.64),
          end: AlignmentDirectional(1, 0.64),
        )),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    AppAsset.top_right_splash,
                    width: 100,
                    height: 150,
                    fit: BoxFit.contain,
                    alignment: const Alignment(1.4, -1),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 105, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      AppAsset.icon_splash,
                      width: MediaQuery.sizeOf(context).width * 0.3,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            const Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: TextMain(
                    text: 'E-FORM',
                    size: 25,
                    textColor: Colors.white,
                    textFontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: TextMain(
                    text: 'Buat Pengajuan menjadi \n lebih mudah',
                    size: 16,
                    textColor: Colors.white,
                    textFontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      AppAsset.bottom_splash,
                      width: 121,
                      height: 100,
                      fit: BoxFit.cover,
                      alignment: const Alignment(1, 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
