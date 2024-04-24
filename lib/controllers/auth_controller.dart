import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  static TextEditingController usernameController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();

  static Stream<User?> userChanges() => FirebaseAuth.instance.authStateChanges();

  static void signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: usernameController.text.trim(),
      password: passwordController.text.trim(),
    );
    signIn();
  }

  static void signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text.trim(),
        password: passwordController.text.trim(),
    );
    clearControllers();
  }

  static void signOut() async => await FirebaseAuth.instance.signOut();

  static void clearControllers() {
    usernameController.clear();
    passwordController.clear();
  }
}