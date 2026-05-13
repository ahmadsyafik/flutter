// lib/services/auth_service.dart
// ✅ FILE BARU - Service untuk handle Firebase Authentication

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Instance Firebase Auth (singleton)
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get auth => _auth;

  // Login dengan email dan password
  Future<UserCredential?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      if (_auth == null) {
        throw 'Firebase belum diinisialisasi!';
      }
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } on FirebaseAuthException catch (e) {
      // Lempar error dengan pesan yang lebih ramah
      throw _handleAuthError(e);
    } catch (e) {
      throw 'Kesalahan login: $e';
    }
  }

  // Logout
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Signout error: $e');
      rethrow;
    }
  }

  // Cek apakah user sedang login
  User? get currentUser => _auth.currentUser;

  // Helper untuk pesan error
  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Email tidak ditemukan.';
      case 'wrong-password':
        return 'Password salah.';
      case 'invalid-email':
        return 'Format email tidak valid.';
      case 'user-disabled':
        return 'Akun ini telah dinonaktifkan.';
      case 'too-many-requests':
        return 'Terlalu banyak percobaan. Coba lagi nanti.';
      default:
        return 'Login gagal: ${e.message}';
    }
  }
}
