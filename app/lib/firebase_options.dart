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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAgvRd-6VOQyQsr6Hd18kM7WvJKt8VjWW4',
    appId: '1:872838006159:android:4e67c02454ec5b440937fa',
    messagingSenderId: '872838006159',
    projectId: 'final-36edf',
    storageBucket: 'final-36edf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAmDGldwJGdUxE4kQuG8-Wt5HusUSbuXFs',
    appId: '1:872838006159:ios:d06d71b69cc4f9de0937fa',
    messagingSenderId: '872838006159',
    projectId: 'final-36edf',
    storageBucket: 'final-36edf.appspot.com',
    androidClientId: '872838006159-pom5qki998fpdjp6hmj81ddh2rb6r4ku.apps.googleusercontent.com',
    iosClientId: '872838006159-ajhuqm0d7p76bermb8d81frd4hfjet8f.apps.googleusercontent.com',
    iosBundleId: 'com.example.mdc100Series',
  );
}
