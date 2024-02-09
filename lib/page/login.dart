import 'package:e_form/config/app_asset.dart';
import 'package:e_form/config/app_color.dart';
import 'package:e_form/controller/login.dart';
import 'package:e_form/widget/button_primary.dart';
import 'package:e_form/widget/message_error.dart';
import 'package:e_form/widget/text_input_with_icon.dart';
import 'package:e_form/widget/text_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColor.backgroundScaffold,
      body: SingleChildScrollView(
        child: GetBuilder<LoginController>(
          builder: (_) => Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sectionHeader(context),
              contentBody(context),
              const SizedBox(height: 50),
              Transform.translate(
                offset: const Offset(0, 35),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    AppAsset.bottom_left_login,
                    fit: BoxFit.contain,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column contentBody(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextMain(
                  text: 'Login', size: 20, textFontWeight: FontWeight.w800),
              TextMain(text: 'Sign in to Continue', size: 16)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return TextInputWithIcon(
                    label: 'Email Address',
                    icon: Icons.email_outlined,
                    size: 20,
                    onChanged: _loginController.setEmail,
                    isError: _loginController.errorMessages['email'] != null);
              }),
              Obx(() {
                if (_loginController.errorMessages['email'] != null) {
                  return MessageError(
                    textError: _loginController.errorMessages['email'],
                  );
                }
                return const Text('');
              }),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  return (TextInputWithIcon(
                    icon: Icons.lock_outline,
                    label: 'Password',
                    size: 20,
                    isSecureText: true,
                    onChanged: _loginController.setPassword,
                    isError: _loginController.errorMessages['password'] != null,
                  ));
                }),
                Obx(() {
                  if (_loginController.errorMessages['password'] != null) {
                    return MessageError(
                      textError: _loginController.errorMessages['password'],
                    );
                  }
                  return const Text('');
                }),
              ],
            )),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Stack(
              alignment: const AlignmentDirectional(0, -1),
              children: [
                ButtonPrimary(
                  label: 'Login',
                  onTap: () {
                    _loginController.login();
                  },
                ),
                Positioned(
                  right: -10,
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      AppAsset.center_right_login,
                      width: 40,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 0),
          child: TextMain(
            text: 'Forgot Password?',
            textFontWeight: FontWeight.w500,
          ),
        ),
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(30, 40, 30, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextMain(
                text: 'Do Have an Account ?',
                textFontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ],
    );
  }

  SizedBox sectionHeader(BuildContext context) {
    return SizedBox(
      height: 240, // Sesuaikan dengan tinggi maksimal yang diinginkan
      child: Stack(
        children: [
          Positioned(
            left: -60,
            top: -60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                AppAsset.top_left_login,
                width: 219,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: MediaQuery.of(context).size.width * 0.3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                AppAsset.header_login,
                fit: BoxFit.contain,
                width: 200,
              ),
            ),
          ),
          Positioned(
            right: 30,
            top: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                AppAsset.top_right_login,
                width: 40,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
