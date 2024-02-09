import 'package:e_form/config/app_asset.dart';
import 'package:e_form/config/app_color.dart';
import 'package:e_form/page/menuBar.dart';
import 'package:e_form/widget/button_primary.dart';
import 'package:e_form/widget/list_menu_profile.dart';
import 'package:e_form/widget/text_main.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          const SizedBox(height: 10),
          photoProfile(),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              const TextMain(
                text: 'Bima Ega Farizky',
                textFontWeight: FontWeight.bold,
                size: 16,
              ),
              const TextMain(
                text: 'bimaega15@gmail.com',
                textFontWeight: FontWeight.normal,
                size: 14,
              ),
              const SizedBox(
                height: 10,
              ),
              ButtonPrimary(
                label: 'Edit Profile',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MenuBarPage()),
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ListMenuProfile(
                  context: context,
                  icon: Icons.verified_user_outlined,
                  label: 'Privacy'),
              const SizedBox(
                height: 10,
              ),
              ListMenuProfile(
                  context: context,
                  icon: Icons.help_outline_outlined,
                  label: 'Help & Support'),
              const SizedBox(
                height: 10,
              ),
              ListMenuProfile(
                  context: context,
                  icon: Icons.lock_outline,
                  label: 'Ganti Password'),
              const SizedBox(
                height: 10,
              ),
              ListMenuProfile(
                  context: context,
                  icon: Icons.logout_outlined,
                  label: 'Logout'),
            ],
          )
        ],
      ),
    );
  }

  Row photoProfile() {
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
            child: ClipOval(
              child: Image.asset(
                AppAsset.person_1,
                width: 120,
                height: 120,
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
              child: const Center(
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),
          )
        ])
      ],
    );
  }
}
