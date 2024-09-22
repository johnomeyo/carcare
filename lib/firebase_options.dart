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
    apiKey: 'AIzaSyAkgJE9zY23SQExzg58OoSFNkenwO6BLHQ',
    appId: '1:62029558948:android:2ce94b5bf318e5a2e92231',
    messagingSenderId: '62029558948',
    projectId: 'carcare-6da3d',
    storageBucket: 'carcare-6da3d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBfLa1VIhea4E4ptw9ijFCo6zW05wu-Lz8',
    appId: '1:62029558948:ios:833629e4440df6d6e92231',
    messagingSenderId: '62029558948',
    projectId: 'carcare-6da3d',
    storageBucket: 'carcare-6da3d.appspot.com',
    androidClientId: '62029558948-ae456vmetr7h0be481f7q7b6gi5rqunp.apps.googleusercontent.com',
    iosClientId: '62029558948-m1imku9boo4i6ufi2rg1stdrs9t7c7n8.apps.googleusercontent.com',
    iosBundleId: 'com.example.carcare',
  );

}