import 'package:e_form/config/api_service.dart';
import 'package:e_form/controller/c_notifikasi.dart';
import 'package:flutter/material.dart';
import 'package:e_form/config/app_color.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Notifikasi extends StatefulWidget {
  const Notifikasi({super.key});

  @override
  State<Notifikasi> createState() => _NotifikasiState();
}

class _NotifikasiState extends State<Notifikasi> {
  CNotifikasi cNotifikasi = Get.put(CNotifikasi());
  late List<Map<String, dynamic>> notificationsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundScaffold,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          'Notifikasi',
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
        centerTitle: true,
      ),
      body: Expanded(
        child: Obx(() {
          if (notificationsList.isEmpty) {
            return Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.notifications_off_sharp,
                      color: AppColor.greyColor,
                      size: 100,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Tidak ada notifikasi',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return ListView(
              children: notificationsList
                  .map((notification) => Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(notification['title']),
                          subtitle: Text(notification['body']),
                          trailing: Container(
                            width: 50,
                            height: 50,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              "${ApiService.baseRoot}/upload/profile/${notification['image']}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            );
          }
        }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      notificationsList = cNotifikasi.notificationsList;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cNotifikasi.clearNotifications();
    });
    super.dispose();
  }
}
