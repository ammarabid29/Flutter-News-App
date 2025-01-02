import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/utils/utils.dart';

class SignupViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool loading = false;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter email";
    } else if (!value.contains("@") || !value.contains(".")) {
      return "Enter a valid email address";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter password";
    } else if (value.length < 6) {
      return "Password length should greater than 6";
    }
    return null;
  }

  void handleSignup({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required Function(bool) setLoading,
  }) {
    setLoading(true);

    FocusScope.of(context).unfocus();

    if (formKey.currentState!.validate()) {
      _auth
          .createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString(),
      )
          .then(
        (value) {
          setLoading(false);
          emailController.clear();
          passwordController.clear();
        },
      ).onError(
        (error, stackTrace) {
          setLoading(false);
          Utils().toastMessage(error.toString());
        },
      );
    } else {
      setLoading(false);
    }
  }

  void navigateToLoginScreen(BuildContext context) {
    Navigator.of(context).pop();
  }
}
