import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

/// Listens to Firebase auth state changes and notifies GoRouter to re-evaluate redirects.
class _AuthStateNotifier extends ChangeNotifier {
  _AuthStateNotifier() {
    FirebaseAuth.instance.authStateChanges().listen((_) {
      notifyListeners();
    });
  }
}

class FirebaseAuthRepository {
  final _auth = FirebaseAuth.instance;
  final authStateNotifier = _AuthStateNotifier();

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Sign in with email and password (works reliably with Auth Emulator)
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      debugPrint('Email Sign-In error: ${e.code} — ${e.message}');
      rethrow;
    }
  }

  /// Sign in with Google (for production use)
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final provider = GoogleAuthProvider();
      provider.addScope('email');
      provider.addScope('profile');
      return await _auth.signInWithPopup(provider);
    } on FirebaseAuthException catch (e) {
      debugPrint('Google Sign-In error: ${e.code} — ${e.message}');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
