// ignore_for_file: file_names

import 'package:e_form/config/app_color.dart';
import 'package:e_form/config/app_route.dart';
import 'package:e_form/controller/c_menubar.dart';
import 'package:e_form/page/history.dart';
import 'package:e_form/page/home.dart';
import 'package:e_form/page/profile.dart';
import 'package:e_form/page/transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuBarPage extends StatefulWidget {
  const MenuBarPage({super.key});

  @override
  State<MenuBarPage> createState() => _MenuBarPageState();
}

class _MenuBarPageState extends State<MenuBarPage> {
  final cMenuBar = Get.put(CMenuBar());

  final List<Map> listNav = [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.event_note_rounded, 'label': 'History'},
    {'icon': Icons.send_outlined, 'label': 'Transaction'},
    {'icon': Icons.account_circle, 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (cMenuBar.indexPage == 0) {
          return const Home();
        }
        if (cMenuBar.indexPage == 1) {
          return const History();
        }
        if (cMenuBar.indexPage == 2) {
          return const Transaction();
        }

        return const Profile();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoute.formTransaction);
        },
        shape: const CircleBorder(),
        elevation: 5,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () {
          return Material(
            elevation: 8,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 8, bottom: 6),
              child: BottomNavigationBar(
                currentIndex: cMenuBar.indexPage,
                onTap: (value) => cMenuBar.indexPage = value,
                elevation: 5,
                backgroundColor: AppColor.backgroundScaffold,
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.black,
                selectedIconTheme: const IconThemeData(
                  color: AppColor.primary,
                ),
                selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                selectedFontSize: 12,
                items: listNav.map((e) {
                  return BottomNavigationBarItem(
                    icon: Icon(e['icon']),
                    label: e['label'],
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
