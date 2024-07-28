import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CNotifikasi extends GetxController {
  var notificationsList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotificationsFromPrefs();
  }

  void saveNotification(Map<String, dynamic> newNotification) async {
    // Check if new notification has unique id and num
    bool isUnique = !notificationsList
        .any((notification) => notification['key'] == newNotification['key']);

    if (isUnique) {
      // Add the new notification to the list
      notificationsList.add(newNotification);
      await saveNotificationsToPrefs();
    }
  }

  int getNotificationCount() {
    return notificationsList.length;
  }

  void clearNotifications() async {
    notificationsList.value = [];
    await saveNotificationsToPrefs();
  }

  Future<void> saveNotificationsToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notifications = notificationsList
        .map((notification) => jsonEncode(notification))
        .toList();
    await prefs.setStringList('notifications', notifications);
  }

  Future<void> loadNotificationsFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? notifications = prefs.getStringList('notifications');
    if (notifications != null) {
      notificationsList.value = notifications
          .map<Map<String, dynamic>>((notification) => jsonDecode(notification))
          .toList();
    }
  }
}
