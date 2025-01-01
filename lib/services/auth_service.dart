import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String _userKey = 'user_profile';

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  // Simple user profile
  Future<Map<String, dynamic>?> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      return Map<String, dynamic>.from(
        const JsonDecoder().convert(userJson),
      );
    }
    return null;
  }

  // Demo account
  Future<UserCredential?> signInDemo() async {
    try {
      return await _auth.signInAnonymously();
    } catch (e) {
      debugPrint('Demo sign in failed: $e');
      return null;
    }
  }

  // Phone auth
  Future<void> verifyPhone({
    required String phoneNumber,
    required Function(String) onCodeSent,
    required Function(String) onError,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          onError(e.message ?? 'Verification failed');
        },
        codeSent: (String verificationId, int? resendToken) {
          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      onError(e.toString());
    }
  }

  Future<UserCredential?> verifyCode(
    String verificationId,
    String smsCode,
  ) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      debugPrint('Code verification failed: $e');
      return null;
    }
  }

  // Basic profile management
  Future<void> updateProfile(Map<String, dynamic> profile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _userKey,
        const JsonEncoder().convert(profile),
      );
    } catch (e) {
      debugPrint('Profile update failed: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
    } catch (e) {
      debugPrint('Sign out failed: $e');
    }
  }
}
