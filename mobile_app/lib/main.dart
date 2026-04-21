import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'firebase_options.dart';
import 'core/navigation/AppRouter.dart';
import 'core/theme/AppTheme.dart';

// Toggle this to true if you are running Firebase Emulators locally
const bool useEmulator = true;

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    
    debugPrint('Initializing Firebase...');
    try {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      debugPrint('Firebase initialized.');
      
      if (kDebugMode && useEmulator) {
        String host = 'localhost';
        
        // For Android Emulator, use 10.0.2.2 to access host's localhost
        if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
          host = '10.0.2.2';
        }
            
        debugPrint('Connecting to Firebase Emulators at $host...');
        await FirebaseAuth.instance.useAuthEmulator(host, 9099);
        FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
        // Note: Storage emulator might fail if not explicitly in pubspec, adding it now
        try {
          FirebaseStorage.instance.useStorageEmulator(host, 9199);
        } catch (e) {
          debugPrint('Storage Emulator not available: $e');
        }
        debugPrint('Successfully configured Firebase Emulators.');
      } else {
        debugPrint('Using Production/Cloud Firebase.');
      }
    } catch (e) {
      debugPrint('Firebase Init Error: $e');
      // If Firebase fails, we still want to try to run the app 
      // but it will likely fail later.
    }

    runApp(const ProviderScope(child: MainApp()));
  } catch (e, stack) {
    debugPrint('CRITICAL STARTUP ERROR: $e');
    debugPrint(stack.toString());
    runApp(MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: SelectableText('Critical App Startup Error:\n\n$e\n\n$stack'),
            ),
          ),
        ),
      ),
    ));
  }
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Opi Suomea',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: router,
    );
  }
}
