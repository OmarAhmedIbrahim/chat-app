import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void ShowSnakBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

Future<bool> AuthenticationUsingEmailPass(
    {required String emailAddress,
    required String password,
    required BuildContext context}) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      ShowSnakBar(context, "Password is too weak");
    } else if (e.code == 'email-already-in-use') {
      ShowSnakBar(context, "Email is already in use ");
    } else if (e.code == 'invalid-email') {
      ShowSnakBar(context, 'Invalid email');
    }
    return false;
  }
}

Future<bool> LoginUsingEmailPass(
    {required String emailAddress,
    required String password,
    required BuildContext context}) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      ShowSnakBar(context, 'User not found');
    } else if (e.code == 'wrong-password') {
      ShowSnakBar(context, 'Wrong Password');
    } else if (e.code == 'invalid-email') {
      ShowSnakBar(context, 'Invalid email');
    } else if (e.code == 'invalid-credential') {
      ShowSnakBar(context, 'Either the Email or the Password are wrong');
    }
    return false;
  }
}
