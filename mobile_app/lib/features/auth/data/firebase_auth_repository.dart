import 'package:cloud_firestore/cloud_firestore.dart';
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
  final _db = FirebaseFirestore.instance;
  final authStateNotifier = _AuthStateNotifier();

  FirebaseAuthRepository() {
    // Tự động đồng bộ hồ sơ người dùng khi trạng thái đăng nhập thay đổi
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        syncUserProfile(user);
      }
    });
  }

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Đăng nhập bằng email và mật khẩu
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (cred.user != null) {
        await syncUserProfile(cred.user!);
      }
      return cred;
    } on FirebaseAuthException catch (e) {
      debugPrint('Email Sign-In error: ${e.code} — ${e.message}');
      rethrow;
    }
  }

  /// Đăng ký tài khoản mới bằng email và mật khẩu
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (displayName != null && displayName.isNotEmpty && cred.user != null) {
        await cred.user!.updateDisplayName(displayName);
      }
      if (cred.user != null) {
        await syncUserProfile(cred.user!);
      }
      return cred;
    } on FirebaseAuthException catch (e) {
      debugPrint('Email Sign-Up error: ${e.code} — ${e.message}');
      rethrow;
    }
  }

  /// Đăng nhập bằng Google (hỗ trợ cả Web Popup và Native Provider)
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final provider = GoogleAuthProvider();
      provider.addScope('email');
      provider.addScope('profile');
      UserCredential? cred;
      if (kIsWeb) {
        cred = await _auth.signInWithPopup(provider);
      } else {
        cred = await _auth.signInWithProvider(provider);
      }
      final user = cred.user;
      if (user != null) {
        await syncUserProfile(user);
      }
      return cred;
    } on FirebaseAuthException catch (e) {
      debugPrint('Google Sign-In error: ${e.code} — ${e.message}');
      rethrow;
    }
  }

  /// Đồng bộ hồ sơ học viên vào collection 'users' trên Firestore
  Future<void> syncUserProfile(User user) async {
    try {
      final userRef = _db.collection('users').doc(user.uid);
      final doc = await userRef.get();
      final now = FieldValue.serverTimestamp();

      if (!doc.exists) {
        await userRef.set({
          'id': user.uid,
          'email': user.email ?? '',
          'displayName': user.displayName ?? (user.email?.split('@').first ?? 'Opiskelija'),
          'photoUrl': user.photoURL,
          'role': 'user',
          'createdAt': now,
          'lastLoginAt': now,
        });
        debugPrint('Created user profile in Firestore for UID: ${user.uid}');
      } else {
        await userRef.update({
          'lastLoginAt': now,
          if (user.displayName != null && user.displayName!.isNotEmpty)
            'displayName': user.displayName,
          if (user.photoURL != null && user.photoURL!.isNotEmpty)
            'photoUrl': user.photoURL,
        });
      }
    } catch (e) {
      debugPrint('Error syncing user profile: $e');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
