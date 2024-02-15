import 'package:e_form/config/app_color.dart';
import 'package:e_form/controller/c_auth.dart';
import 'package:e_form/controller/c_edit_profile.dart';
import 'package:e_form/controller/c_profile.dart';
import 'package:e_form/widget/button_primary.dart';
import 'package:e_form/widget/text_input_with_label.dart';
import 'package:e_form/widget/text_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum GenderProfile { L, P }

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  CAuth cAuth = Get.put(CAuth());
  CProfile cProfile = Get.put(CProfile());

  CEditProfile cEditProfile = Get.put(CEditProfile());
  GenderProfile? _gender = GenderProfile.L;

  Future<void> onSubmit() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Obx(() => AlertDialog(
              title: const TextMain(
                text: 'Edit Profile',
                textFontWeight: FontWeight.bold,
                size: 24,
              ),
              content:
                  const Text('Apakah sudah yakin untuk update profile ini?\n'),
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
                  child: cEditProfile.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text('Submit'),
                  onPressed: () {
                    formSubmit();

                    if (!cEditProfile.isLoading.value) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ));
      },
    );
  }

  void formSubmit() {
    var users = cAuth.authData.value.users;
    cEditProfile.submitForm(users['id']);
  }

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> myProfile = cProfile.profileData.value.profile;
    cEditProfile.setNikProfile(myProfile['profile']['nik_profile']);
    cEditProfile.nik_profile_controller.text =
        myProfile['profile']['nik_profile'];
    cEditProfile.setNamaProfile(myProfile['profile']['nama_profile']);
    cEditProfile.nama_profile_controller.text =
        myProfile['profile']['nama_profile'];
    cEditProfile.setEmailProfile(myProfile['profile']['email_profile']);
    cEditProfile.email_profile_controller.text =
        myProfile['profile']['email_profile'];
    cEditProfile.setNoHpProfile(myProfile['profile']['nohp_profile']);
    cEditProfile.nohp_profile_controller.text =
        myProfile['profile']['nohp_profile'];
    cEditProfile
        .setJenisKelaminProfile(myProfile['profile']['jeniskelamin_profile']);
    cEditProfile.setAlamatProfile(myProfile['profile']['alamat_profile']);
    cEditProfile.alamat_profile_controller.text =
        myProfile['profile']['alamat_profile'];
    if (myProfile['profile']['jeniskelamin_profile'] == 'L') {
      setState(() {
        _gender = GenderProfile.L;
      });
    } else {
      _gender = GenderProfile.P;
    }
  }

  @override
  void dispose() {
    super.dispose();
    cEditProfile.resetForm();
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
          'Edit Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextInputWithLabel(
                  label: 'NIK',
                  heightError: 20,
                  maxLines: 1,
                  onChanged: cEditProfile.setNikProfile,
                  isError: cEditProfile.errorMessages['nik_profile'],
                  controller: cEditProfile.nik_profile_controller,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextInputWithLabel(
                  label: 'Nama',
                  heightError: 20,
                  maxLines: 1,
                  onChanged: cEditProfile.setNamaProfile,
                  isError: cEditProfile.errorMessages['nama_profile'],
                  controller: cEditProfile.nama_profile_controller,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextInputWithLabel(
                  label: 'Email',
                  heightError: 20,
                  maxLines: 1,
                  onChanged: cEditProfile.setEmailProfile,
                  isError: cEditProfile.errorMessages['email_profile'],
                  controller: cEditProfile.email_profile_controller,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextInputWithLabel(
                  label: 'No. Handphone',
                  onChanged: cEditProfile.setNoHpProfile,
                  heightError: 20,
                  maxLines: 1,
                  isError: cEditProfile.errorMessages['nohp_profile'],
                  controller: cEditProfile.nohp_profile_controller,
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextMain(
                  text: 'Jenis Kelamin',
                  textFontWeight: FontWeight.w500,
                  size: 16,
                ),
                RadioListTile(
                  title: const Text('Laki-laki'),
                  value: GenderProfile.L,
                  groupValue: _gender,
                  onChanged: (val) {
                    setState(() {
                      _gender = val;
                    });
                    cEditProfile
                        .setJenisKelaminProfile(val.toString().split('.').last);
                  },
                ),
                RadioListTile(
                  title: const Text('Perempuan'),
                  value: GenderProfile.P,
                  groupValue: _gender,
                  onChanged: (val) {
                    setState(() {
                      _gender = val;
                    });
                    cEditProfile
                        .setJenisKelaminProfile(val.toString().split('.').last);
                  },
                ),
                if (cEditProfile.errorMessages['jeniskelamin_profile'] != null)
                  TextMain(
                    text: cEditProfile.errorMessages['jeniskelamin_profile']!,
                    textColor: AppColor.errorColor,
                    size: 12,
                  ),
                const SizedBox(
                  height: 10,
                ),
                TextInputWithLabel(
                  label: 'Alamat Profile',
                  onChanged: cEditProfile.setAlamatProfile,
                  heightError: 20,
                  maxLines: 5,
                  isError: cEditProfile.errorMessages['alamat_profile'],
                  controller: cEditProfile.alamat_profile_controller,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  color: AppColor.borderColor,
                  thickness: 0.2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ButtonPrimary(
                        label: 'Cancel',
                        onTap: () {
                          Get.back();
                        },
                        color: AppColor.errorColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ButtonPrimary(
                        label: 'Submit',
                        onTap: () {
                          onSubmit();
                        },
                        color: AppColor.secondary,
                      ),
                    ),
                  ],
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
