import 'package:e_form/config/app_color.dart';
import 'package:e_form/controller/c_auth.dart';
import 'package:e_form/controller/c_change_password.dart';
import 'package:e_form/widget/button_primary.dart';
import 'package:e_form/widget/text_input_with_label.dart';
import 'package:e_form/widget/text_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _obscureTextOldPassword = true;
  bool _obscureTextNewPassword = true;
  bool _obscureTextConfirmNewPassword = true;

  CChangePassword cChangePassword = Get.put(CChangePassword());
  CAuth cAuth = Get.put(CAuth());

  Future<void> onSubmit() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Obx(() => AlertDialog(
              title: const TextMain(
                text: 'Change Password',
                textFontWeight: FontWeight.bold,
                size: 24,
              ),
              content: const Text(
                  'Apakah sudah yakin dengan password yang akan diganti?\n'),
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
                  child: cChangePassword.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text('Submit'),
                  onPressed: () {
                    formSubmit();

                    if (!cChangePassword.isLoading.value) {
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
    if (!cChangePassword.hasErrors()) {
      var users = cAuth.authData.value.users;
      cChangePassword.submitForm(users['id']);
    }
  }

  @override
  void dispose() {
    super.dispose();
    cChangePassword.resetForm();
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
          'Ganti Password',
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
          child: Obx(
            () => Column(
              children: [
                TextInputWithLabel(
                  label: 'Password Lama',
                  onChanged: cChangePassword.setPasswordLama,
                  obscureText: _obscureTextOldPassword,
                  suffixIcon: _obscureTextOldPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                  onTapSuffixIcon: () {
                    setState(() {
                      _obscureTextOldPassword = !_obscureTextOldPassword;
                    });
                  },
                  isError: cChangePassword.errorMessages['password_lama'],
                  heightError: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextInputWithLabel(
                  label: 'Password Baru',
                  onChanged: cChangePassword.setPasswordBaru,
                  obscureText: _obscureTextNewPassword,
                  suffixIcon: _obscureTextNewPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                  onTapSuffixIcon: () {
                    setState(() {
                      _obscureTextNewPassword = !_obscureTextNewPassword;
                    });
                  },
                  isError: cChangePassword.errorMessages['password_baru'],
                  heightError: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextInputWithLabel(
                  label: 'Konfirmasi Password Baru',
                  onChanged: cChangePassword.setKonfirmasiPasswordBaru,
                  obscureText: _obscureTextConfirmNewPassword,
                  suffixIcon: _obscureTextConfirmNewPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                  onTapSuffixIcon: () {
                    setState(() {
                      _obscureTextConfirmNewPassword =
                          !_obscureTextConfirmNewPassword;
                    });
                  },
                  isError:
                      cChangePassword.errorMessages['konfirmasi_password_baru'],
                  heightError: 20,
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
            ),
          ),
        ),
      ),
    );
  }
}
