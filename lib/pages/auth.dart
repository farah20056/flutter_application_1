import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // المستخدم الحالي
  User? get currentUser => _firebaseAuth.currentUser;

  // متابعة تغييرات حالة تسجيل الدخول
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // تسجيل الدخول
  Future<void> signInWithEmailAndPassword({
    required BuildContext ctx,
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      ScaffoldMessenger.of(
        ctx,
      ).showSnackBar(const SnackBar(content: Text("Login successful")));
    } catch (e) {
      ScaffoldMessenger.of(
        ctx,
      ).showSnackBar(SnackBar(content: Text("Login failed: $e")));
    }
  }

  // إنشاء حساب جديد
  Future<void> createUserWithEmailAndPassword({
    required BuildContext ctx,
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(content: Text("Account created successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        ctx,
      ).showSnackBar(SnackBar(content: Text("Account creation failed: $e")));
    }
  }

  // تسجيل الخروج
  Future<void> signOut(BuildContext ctx) async {
    await _firebaseAuth.signOut();
    ScaffoldMessenger.of(
      ctx,
    ).showSnackBar(const SnackBar(content: Text("Signed out")));
  }
}
