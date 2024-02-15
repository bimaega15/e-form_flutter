import 'dart:io';

import 'package:e_form/config/api_service.dart';
import 'package:e_form/config/app_color.dart';
import 'package:e_form/config/app_route.dart';
import 'package:e_form/controller/c_auth.dart';
import 'package:e_form/controller/c_profile.dart';
import 'package:e_form/controller/c_upload_photo.dart';
import 'package:e_form/models/uploadPhoto.dart';
import 'package:e_form/widget/button_primary.dart';
import 'package:e_form/widget/list_menu_profile.dart';
import 'package:e_form/widget/text_main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  CAuth cAuth = Get.put(CAuth());
  CProfile cProfile = Get.put(CProfile());
  CUploadPhoto cUploadPhoto = Get.put(CUploadPhoto());

  Future<void> authLogout() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const TextMain(
            text: 'System Logout',
            textFontWeight: FontWeight.bold,
            size: 24,
          ),
          content:
              const Text('Apakah anda yakin ingin keluar dari aplikasi?\n'),
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
              child: const Text('Submit'),
              onPressed: () {
                cAuth.logout();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    var users = cAuth.authData.value.users;

    if (result != null) {
      cUploadPhoto.setGambarProfile(File(result.files.single.path!));
      UploadPhoto uploadPhoto =
          UploadPhoto(gambar_profile: File(result.files.single.path!));
      cUploadPhoto.submitForm(users['id'], uploadPhoto.convertoFormData());
    }
  }

  @override
  void initState() {
    super.initState();
    cProfile.fetchMyProfile();
  }

  @override
  void dispose() {
    super.dispose();
    cProfile.resetMyProfile();
    cUploadPhoto.resetForm();
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
          'Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<CProfile>(
          init: CProfile(),
          builder: (controller) {
            // print(controller.profileData.value.profile);
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            Map<String, dynamic> myProfile =
                controller.profileData.value.profile;

            return ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                const SizedBox(height: 10),
                photoProfile(myProfile),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    TextMain(
                      text: myProfile['profile']['nama_profile'],
                      textFontWeight: FontWeight.bold,
                      size: 16,
                    ),
                    TextMain(
                      text: myProfile['profile']['email_profile'],
                      textFontWeight: FontWeight.normal,
                      size: 14,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ButtonPrimary(
                      label: 'Edit Profile',
                      onTap: () {
                        Get.toNamed(AppRoute.editProfile);
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ListMenuProfile(
                        onTap: () {
                          Get.toNamed(AppRoute.privacy);
                        },
                        context: context,
                        icon: Icons.verified_user_outlined,
                        label: 'Privacy'),
                    const SizedBox(
                      height: 10,
                    ),
                    ListMenuProfile(
                        onTap: () {
                          Get.toNamed(AppRoute.helpSupport);
                        },
                        context: context,
                        icon: Icons.help_outline_outlined,
                        label: 'Help & Support'),
                    const SizedBox(
                      height: 10,
                    ),
                    ListMenuProfile(
                        onTap: () {
                          Get.toNamed(AppRoute.changePassword);
                        },
                        context: context,
                        icon: Icons.lock_outline,
                        label: 'Ganti Password'),
                    const SizedBox(
                      height: 10,
                    ),
                    ListMenuProfile(
                        onTap: () {
                          authLogout();
                        },
                        context: context,
                        icon: Icons.logout_outlined,
                        label: 'Logout'),
                  ],
                )
              ],
            );
          }),
    );
  }

  Row photoProfile(myProfile) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.backgroundCard,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x33000000),
                  offset: Offset(2, 3),
                )
              ],
              border: Border.all(
                color: AppColor.secondary,
                width: 2,
              ),
            ),
            child: Container(
              width: 100,
              height: 100,
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
          Positioned(
            bottom: 0,
            right: 5,
            child: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.primary,
              ),
              child: Center(
                child: IconButton(
                    onPressed: () {
                      _pickFile();
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 14,
                    )),
              ),
            ),
          )
        ])
      ],
    );
  }
}
