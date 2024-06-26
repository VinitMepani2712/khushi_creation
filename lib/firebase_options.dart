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
    apiKey: 'AIzaSyCBIJQfQNcswUxvdm1CTaAcBl4wPoNs39o',
    appId: '1:582987484469:web:b8fb75c7e0721f6c5f507c',
    messagingSenderId: '582987484469',
    projectId: 'khushi-creation-73a7a',
    authDomain: 'khushi-creation-73a7a.firebaseapp.com',
    storageBucket: 'khushi-creation-73a7a.appspot.com',
    measurementId: 'G-JM7QS36EWS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDetaaXMKpHygHPqc-WnLCdS9FBv5hMUU8',
    appId: '1:582987484469:android:f64c35d416a7fd375f507c',
    messagingSenderId: '582987484469',
    projectId: 'khushi-creation-73a7a',
    storageBucket: 'khushi-creation-73a7a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBhJNO3qEvCiEoZAXdKDQaPJAEhNjoNCac',
    appId: '1:582987484469:ios:e9dd2b016bf1b5195f507c',
    messagingSenderId: '582987484469',
    projectId: 'khushi-creation-73a7a',
    storageBucket: 'khushi-creation-73a7a.appspot.com',
    iosClientId: '582987484469-opdhugt3hqup44fivki0eqnshvusk0la.apps.googleusercontent.com',
    iosBundleId: 'com.example.khushiCreation',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBhJNO3qEvCiEoZAXdKDQaPJAEhNjoNCac',
    appId: '1:582987484469:ios:e9dd2b016bf1b5195f507c',
    messagingSenderId: '582987484469',
    projectId: 'khushi-creation-73a7a',
    storageBucket: 'khushi-creation-73a7a.appspot.com',
    iosClientId: '582987484469-opdhugt3hqup44fivki0eqnshvusk0la.apps.googleusercontent.com',
    iosBundleId: 'com.example.khushiCreation',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCBIJQfQNcswUxvdm1CTaAcBl4wPoNs39o',
    appId: '1:582987484469:web:d2cd061dcbd99ecd5f507c',
    messagingSenderId: '582987484469',
    projectId: 'khushi-creation-73a7a',
    authDomain: 'khushi-creation-73a7a.firebaseapp.com',
    storageBucket: 'khushi-creation-73a7a.appspot.com',
    measurementId: 'G-25L7ER5FPB',
  );
}
