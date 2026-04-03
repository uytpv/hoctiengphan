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
    apiKey: 'dummy-api-key-for-emulator',
    appId: '1:1234567890:web:abcdef',
    messagingSenderId: '1234567890',
    projectId: 'hoctiengphan-dev',
    authDomain: 'hoctiengphan-dev.firebaseapp.com',
    storageBucket: 'hoctiengphan-dev.appspot.com',
  );
}
