import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final userDocProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return null;
  
  final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  return doc.data();
});

final isAdminProvider = Provider<bool>((ref) {
  final userDoc = ref.watch(userDocProvider).value;
  if (userDoc == null) return false;
  return userDoc['role'] == 'admin';
});

class AuthNotifier extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async {
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    // Force update build result
    state = AsyncData(FirebaseAuth.instance.currentUser);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    state = const AsyncData(null);
  }

  Future<void> updatePassword(String newPassword) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updatePassword(newPassword);
    }
  }
}

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, User?>(AuthNotifier.new);
