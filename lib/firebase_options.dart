// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAczNNcc0AuIk5l0ZUyBjA4nGI_AQSzXKU',
    appId: '1:1011610878049:web:5b3df42291773b3955aa20',
    messagingSenderId: '1011610878049',
    projectId: 'es-project-vertical-slice-1',
    authDomain: 'es-project-vertical-slice-1.firebaseapp.com',
    storageBucket: 'es-project-vertical-slice-1.appspot.com',
    measurementId: 'G-0J76YLF33M',
    // databaseURL:   'https://s-project-vertical-slice-1.firebaseapp.app', // could be wrong
    databaseURL: 'https://es-project-vertical-slice-1.firebaseio.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDnj82QB0NMfjaMitinkGqNwvbq0FPynwY',
    appId: '1:1011610878049:android:4bb7d362f3c19cea55aa20',
    messagingSenderId: '1011610878049',
    projectId: 'es-project-vertical-slice-1',
    storageBucket: 'es-project-vertical-slice-1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDmRl0yhFJg-DAQ3A9xELHfNDBz4jE8Q6Y',
    appId: '1:1011610878049:ios:a211a9a74d88466b55aa20',
    messagingSenderId: '1011610878049',
    projectId: 'es-project-vertical-slice-1',
    storageBucket: 'es-project-vertical-slice-1.appspot.com',
    iosBundleId: 'com.example.v2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDmRl0yhFJg-DAQ3A9xELHfNDBz4jE8Q6Y',
    appId: '1:1011610878049:ios:960519b70a25e29c55aa20',
    messagingSenderId: '1011610878049',
    projectId: 'es-project-vertical-slice-1',
    storageBucket: 'es-project-vertical-slice-1.appspot.com',
    iosBundleId: 'com.example.v2.RunnerTests',
  );
}