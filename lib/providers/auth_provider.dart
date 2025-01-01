import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

final authProvider = StateNotifierProvider<AuthNotifier, User?>(
  (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<User?> {
  final _auth = AuthService();
  
  AuthNotifier() : super(null) {
    // Listen to auth state changes
    FirebaseAuth.instance.authStateChanges().listen((user) {
      state = user;
    });
  }

  Future<bool> signInDemo() async {
    final result = await _auth.signInDemo();
    return result != null;
  }

  Future<void> verifyPhone({
    required String phoneNumber,
    required Function(String) onCodeSent,
    required Function(String) onError,
  }) async {
    await _auth.verifyPhone(
      phoneNumber: phoneNumber,
      onCodeSent: onCodeSent,
      onError: onError,
    );
  }

  Future<bool> verifyCode(String verificationId, String code) async {
    final result = await _auth.verifyCode(verificationId, code);
    return result != null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
