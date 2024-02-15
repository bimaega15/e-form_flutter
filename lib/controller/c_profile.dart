import 'package:e_form/models/myProfile.dart';
import 'package:e_form/source/ProfileSource.dart';
import 'package:get/get.dart' hide Response;

class ProfileData {
  Map<String, dynamic> profile;
  Map<String, dynamic> atasan;

  ProfileData({required this.profile, required this.atasan});

  Map<String, dynamic> get toJson {
    return {
      "profile": profile,
      "atasan": atasan,
    };
  }
}

class CProfile extends GetxController {
  Rx<ProfileData> profileData = ProfileData(profile: {}, atasan: {}).obs;
  RxBool isLoading = false.obs;

  void setProfile(Map<String, dynamic> userData) {
    ProfileData data = ProfileData(
      profile: userData['profile'],
      atasan: userData['atasan'],
    );
    profileData.value = data;
  }

  void fetchMyProfile() async {
    try {
      isLoading.value = true;
      final myProfile = await ProfileSource.myProfile();
      ResponseProfile responseProfile =
          ResponseProfile.fromJson(myProfile['result']);
      setProfile(responseProfile.toJson());
      isLoading.value = false;
    } catch (error) {
      print(error);
      // Utils().showSnackbar('error', 'Failed', 'Terjadi kesalahan');
    }

    update();
  }

  void resetMyProfile() {
    profileData.value = ProfileData(profile: {}, atasan: {});
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    fetchMyProfile();
  }
}
