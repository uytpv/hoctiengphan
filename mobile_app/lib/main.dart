import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // TODO: Chạy 'flutterfire configure' để tự tạo file firebase_options.dart
    // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await Firebase.initializeApp(); // Giả lập tạm thời khi chưa cung cấp options
    
    if (kDebugMode) {
      try {
        // Android cần sử dụng 10.0.2.2 thay vì localhost
        final host = defaultTargetPlatform == TargetPlatform.android ? '10.0.2.2' : 'localhost';
        
        await FirebaseAuth.instance.useAuthEmulator(host, 9099);
        FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
        
        print('Firebase Emulators connected ($host).');
      } catch (e) {
        print('Emulator setup failed: $e');
      }
    }
  } catch (e) {
    print('Firebase initialization failed: $e');
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
