import 'package:e_form/config/app_route.dart';
import 'package:e_form/config/session.dart';
import 'package:e_form/config/utils.dart';
import 'package:e_form/models/user.dart';
import 'package:e_form/source/LoginSource.dart';
import 'package:get/get.dart' hide Response;

class LoginController extends GetxController {
  Utils utils = Utils();

  final RxMap<String, String> errorMessages = <String, String>{}.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;

  void setEmail(String value) => email.value = value;
  void setPassword(String value) => password.value = value;

  void addError(String field, String message) {
    errorMessages[field] = message;
  }

  void clearError(String field) {
    errorMessages.remove(field);
  }

  void resetForm() {
    clearError('email');
    clearError('password');
  }

  bool hasErros() {
    bool isError = false;
    resetForm();

    if (email.value.isEmpty) {
      isError = true;
      addError('email', 'Email tidak boleh kosong');
    }

    if (password.value.isEmpty) {
      isError = true;
      addError('password', 'Password tidak boleh kosong');
    }

    return isError;
  }

  void login() async {
    if (!hasErros()) {
      try {
        Map<dynamic, dynamic> responseData =
            await LoginSource.signIn(email.value, password.value);
        ResponseLogin responseLogin =
            ResponseLogin.fromJson(responseData['result']);

        await Session.saveUser(responseLogin);
        utils.showSnackbar('success', 'Successfully', responseData['message']);
        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(AppRoute.home);
      } catch (e) {
        print("Error: $e");
      }
    } else {
      utils.showSnackbar('error', 'Invalid Form Validation',
          'Perhatikan kembali form inputan anda');
    }
  }

  void logout() {
    Session.clearUser();
    Get.toNamed(AppRoute.login);
  }
}
