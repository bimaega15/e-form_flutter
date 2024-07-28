// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB-8Z79mr2iyxsHqiYBQ9_DFF8RZKqnwXU',
    appId: '1:1022309641206:web:fb2d1f58e202cce39a75d7',
    messagingSenderId: '1022309641206',
    projectId: 'eform-3c473',
    authDomain: 'eform-3c473.firebaseapp.com',
    storageBucket: 'eform-3c473.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBnvyfwprFXsUjozGnpHcIL8VKE320HjP4',
    appId: '1:1022309641206:android:1273d1dba4895d679a75d7',
    messagingSenderId: '1022309641206',
    projectId: 'eform-3c473',
    storageBucket: 'eform-3c473.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_O0koJKX8a8Jh48Bvhad_O1D7RsmHaYQ',
    appId: '1:1022309641206:ios:8da8dfb5cdcae40c9a75d7',
    messagingSenderId: '1022309641206',
    projectId: 'eform-3c473',
    storageBucket: 'eform-3c473.appspot.com',
    iosBundleId: 'com.example.eForm',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC_O0koJKX8a8Jh48Bvhad_O1D7RsmHaYQ',
    appId: '1:1022309641206:ios:8da8dfb5cdcae40c9a75d7',
    messagingSenderId: '1022309641206',
    projectId: 'eform-3c473',
    storageBucket: 'eform-3c473.appspot.com',
    iosBundleId: 'com.example.eForm',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB-8Z79mr2iyxsHqiYBQ9_DFF8RZKqnwXU',
    appId: '1:1022309641206:web:d8803238faee8ec39a75d7',
    messagingSenderId: '1022309641206',
    projectId: 'eform-3c473',
    authDomain: 'eform-3c473.firebaseapp.com',
    storageBucket: 'eform-3c473.appspot.com',
  );

}