// ignore_for_file: unnecessary_null_comparison, avoid_print
import 'package:e_form/config/app_color.dart';
import 'package:e_form/config/app_route.dart';
import 'package:e_form/config/session.dart';
import 'package:e_form/controller/c_auth.dart';
import 'package:e_form/controller/c_notifikasi.dart';
import 'package:e_form/page/approve.dart';
import 'package:e_form/page/change_password.dart';
import 'package:e_form/page/detail_transaction.dart';
import 'package:e_form/page/edit_profile.dart';
import 'package:e_form/page/filter_transaction.dart';
import 'package:e_form/page/form_transaction.dart';
import 'package:e_form/page/help_suppport.dart';
import 'package:e_form/page/login.dart';
import 'package:e_form/page/menuBar.dart';
import 'package:e_form/page/notifikasi.dart';
import 'package:e_form/page/privacy.dart';
import 'package:e_form/page/profile.dart';
import 'package:e_form/page/splash.dart';
import 'package:e_form/page/transaction.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
// ignore: unused_import
import 'firebase_options.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'eform-3c473',
  'notif',
  description: 'Channel untuk notifikasi',
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final CNotifikasi cNotifikasi = Get.put(CNotifikasi());
late AudioPlayer _audioPlayer;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final messageData = message.data;
  cNotifikasi.saveNotification(messageData);

  _audioPlayer = AudioPlayer();
  await _playAudio();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  _audioPlayer = AudioPlayer();
  requestNotificationPermission();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  var initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      cNotifikasi.loadNotificationsFromPrefs();
      if (cNotifikasi.notificationsList.isNotEmpty) {
        Get.toNamed(AppRoute.notifikasi);
      }
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    final messageData = message.data;
    cNotifikasi.saveNotification(messageData);

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      // Fetch image from URL
      final imageUri = notification.android?.imageUrl;
      BigPictureStyleInformation? bigPictureStyleInformation;
      if (imageUri != null) {
        final http.Response response = await http.get(Uri.parse(imageUri));
        final Uint8List imageData = response.bodyBytes;
        bigPictureStyleInformation = BigPictureStyleInformation(
          ByteArrayAndroidBitmap(imageData),
          largeIcon: ByteArrayAndroidBitmap(imageData),
          contentTitle: notification.title,
          summaryText: notification.body,
        );
      }

      flutterLocalNotificationsPlugin.show(
        channel.id.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: Importance.high,
            styleInformation: bigPictureStyleInformation,
          ),
        ),
        payload: messageData.toString(),
      );
      await _playAudio();
    }
  });

  // Handle when the app is opened from background
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    final messageData = message.data;
    cNotifikasi.saveNotification(messageData);

    cNotifikasi.loadNotificationsFromPrefs();
    if (cNotifikasi.notificationsList.isNotEmpty) {
      Get.toNamed(AppRoute.notifikasi);
    }
  });

  initializeDateFormatting('id', null).then((_) {
    runApp(const MyApp());
  });
}

Future<void> _playAudio() async {
  await _audioPlayer.play(AssetSource('audios/clink.mp3'));
}

Future<void> requestNotificationPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  cNotifikasi.loadNotificationsFromPrefs();
  if (cNotifikasi.notificationsList.isNotEmpty) {
    Get.toNamed(AppRoute.notifikasi);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: AppColor.backgroundScaffold,
        primaryColor: AppColor.primary,
        colorScheme: const ColorScheme.light(
          primary: AppColor.primary,
          secondary: AppColor.secondary,
        ),
      ),
      routes: {
        '/': (context) {
          return FutureBuilder(
            future: Session.getUser(),
            builder: (context, AsyncSnapshot<CAuth> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.data == null ||
                  snapshot.data!.authData.value.token == '') {
                return const Splash();
              } else {
                return const MenuBarPage();
              }
            },
          );
        },
        AppRoute.intro: (context) => const Splash(),
        AppRoute.login: (context) => const Login(),
        AppRoute.home: (context) => const MenuBarPage(),
        AppRoute.transaction: (context) => const Transaction(),
        AppRoute.detail: (context) => const DetailTransaction(),
        AppRoute.notifikasi: (context) => const Notifikasi(),
        AppRoute.formTransaction: (context) => const FormTransaction(),
        AppRoute.myProfile: (context) => const Profile(),
        AppRoute.approve: (context) => const Approve(),
        AppRoute.privacy: (context) => const Privacy(),
        AppRoute.helpSupport: (context) => const HelpSupport(),
        AppRoute.changePassword: (context) => const ChangePassword(),
        AppRoute.editProfile: (context) => const EditProfile(),
        AppRoute.filterTransaction: (context) => const FilterTransaction(),
      },
    );
  }
}
