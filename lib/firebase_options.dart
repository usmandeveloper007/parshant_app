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
    apiKey: 'AIzaSyD9eyoQP33YWhdmfaJjSy28Fy7ovXRktqY',
    appId: '1:968774900196:web:865b3b3083a6173cc70ff1',
    messagingSenderId: '968774900196',
    projectId: 'parshantapp',
    authDomain: 'parshantapp.firebaseapp.com',
    storageBucket: 'parshantapp.firebasestorage.app',
    measurementId: 'G-7MYEJWJQ93',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBOxzLww6UdauNoF_9AV7wt20W2rQbiDI4',
    appId: '1:968774900196:android:76442853b6cff7f0c70ff1',
    messagingSenderId: '968774900196',
    projectId: 'parshantapp',
    storageBucket: 'parshantapp.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDst5uOj9AYZgcODaopNSGTxGYZSPkGBtY',
    appId: '1:968774900196:ios:c323d5923ad905d3c70ff1',
    messagingSenderId: '968774900196',
    projectId: 'parshantapp',
    storageBucket: 'parshantapp.firebasestorage.app',
    iosBundleId: 'com.example.parshantApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDst5uOj9AYZgcODaopNSGTxGYZSPkGBtY',
    appId: '1:968774900196:ios:c323d5923ad905d3c70ff1',
    messagingSenderId: '968774900196',
    projectId: 'parshantapp',
    storageBucket: 'parshantapp.firebasestorage.app',
    iosBundleId: 'com.example.parshantApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD9eyoQP33YWhdmfaJjSy28Fy7ovXRktqY',
    appId: '1:968774900196:web:760d01f5744285f5c70ff1',
    messagingSenderId: '968774900196',
    projectId: 'parshantapp',
    authDomain: 'parshantapp.firebaseapp.com',
    storageBucket: 'parshantapp.firebasestorage.app',
    measurementId: 'G-7C4QYS314R',
  );
}
