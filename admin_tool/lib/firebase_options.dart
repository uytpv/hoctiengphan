// File này được tự động thiết lập làm Mock Config để chạy Local Emulator Suite
// Khi bạn deploy lên Production, hãy chạy lại lệnh 'flutterfire configure'

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return web;
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCSYtbsj3SzzK0XU724hoBQTvdMCrZk2xQ',
    appId: '1:202348514784:web:71476276fad4c4fd0baf85',
    messagingSenderId: '202348514784',
    projectId: 'hoc-tieng-phan',
    authDomain: 'hoc-tieng-phan.firebaseapp.com',
    storageBucket: 'hoc-tieng-phan.firebasestorage.app',
    measurementId: 'G-MLPX3VRMZQ',
  );

}