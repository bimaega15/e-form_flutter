// ignore_for_file: unnecessary_null_comparison

import 'package:e_form/config/app_color.dart';
import 'package:e_form/config/app_route.dart';
import 'package:e_form/config/session.dart';
import 'package:e_form/controller/c_auth.dart';
import 'package:e_form/page/approve.dart';
import 'package:e_form/page/change_password.dart';
import 'package:e_form/page/detail_transaction.dart';
import 'package:e_form/page/edit_profile.dart';
import 'package:e_form/page/filter_transaction.dart';
import 'package:e_form/page/form_transaction.dart';
import 'package:e_form/page/help_suppport.dart';
import 'package:e_form/page/login.dart';
import 'package:e_form/page/menuBar.dart';
import 'package:e_form/page/privacy.dart';
import 'package:e_form/page/profile.dart';
import 'package:e_form/page/splash.dart';
import 'package:e_form/page/transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('id', null).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: AppColor.backgroundScaffold,
        primaryColor: AppColor.primary,
        colorScheme: const ColorScheme.light(
          primary: AppColor.primary,
          secondary: AppColor.secondary,
        ),
      ),
      routes: {
        '/': (context) {
          return FutureBuilder(
            future: Session.getUser(),
            builder: (context, AsyncSnapshot<CAuth> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.data == null ||
                  snapshot.data!.authData.value.token == '') {
                return const Splash();
              } else {
                return const MenuBarPage();
              }
            },
          );
        },
        AppRoute.intro: (context) => const Splash(),
        AppRoute.login: (context) => const Login(),
        AppRoute.home: (context) => const MenuBarPage(),
        AppRoute.transaction: (context) => const Transaction(),
        AppRoute.detail: (context) => const DetailTransaction(),
        AppRoute.formTransaction: (context) => const FormTransaction(),
        AppRoute.myProfile: (context) => const Profile(),
        AppRoute.approve: (context) => const Approve(),
        AppRoute.privacy: (context) => const Privacy(),
        AppRoute.helpSupport: (context) => const HelpSupport(),
        AppRoute.changePassword: (context) => const ChangePassword(),
        AppRoute.editProfile: (context) => const EditProfile(),
        AppRoute.filterTransaction: (context) => const FilterTransaction(),
      },
    );
  }
}
