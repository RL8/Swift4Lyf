import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        return linux;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCUAO1yQ1vWFlGM_8itnhXpPFSsASP0bXQ',
    appId: '1:700922645376:web:0bd4cd3e7841f371034f65',
    messagingSenderId: '700922645376',
    projectId: 'swift4lyf-cd69a',
    authDomain: 'swift4lyf-cd69a.firebaseapp.com',
    storageBucket: 'swift4lyf-cd69a.firebasestorage.app',
    measurementId: 'G-00DR0FRMS7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCUAO1yQ1vWFlGM_8itnhXpPFSsASP0bXQ',
    appId: '1:700922645376:android:0bd4cd3e7841f371034f65',
    messagingSenderId: '700922645376',
    projectId: 'swift4lyf-cd69a',
    storageBucket: 'swift4lyf-cd69a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCUAO1yQ1vWFlGM_8itnhXpPFSsASP0bXQ',
    appId: '1:700922645376:ios:0bd4cd3e7841f371034f65',
    messagingSenderId: '700922645376',
    projectId: 'swift4lyf-cd69a',
    storageBucket: 'swift4lyf-cd69a.firebasestorage.app',
    iosBundleId: 'com.example.swift4lyf',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCUAO1yQ1vWFlGM_8itnhXpPFSsASP0bXQ',
    appId: '1:700922645376:macos:0bd4cd3e7841f371034f65',
    messagingSenderId: '700922645376',
    projectId: 'swift4lyf-cd69a',
    storageBucket: 'swift4lyf-cd69a.firebasestorage.app',
    iosBundleId: 'com.example.swift4lyf',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCUAO1yQ1vWFlGM_8itnhXpPFSsASP0bXQ',
    appId: '1:700922645376:windows:0bd4cd3e7841f371034f65',
    messagingSenderId: '700922645376',
    projectId: 'swift4lyf-cd69a',
    storageBucket: 'swift4lyf-cd69a.firebasestorage.app',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'AIzaSyCUAO1yQ1vWFlGM_8itnhXpPFSsASP0bXQ',
    appId: '1:700922645376:linux:0bd4cd3e7841f371034f65',
    messagingSenderId: '700922645376',
    projectId: 'swift4lyf-cd69a',
    storageBucket: 'swift4lyf-cd69a.firebasestorage.app',
  );
}
