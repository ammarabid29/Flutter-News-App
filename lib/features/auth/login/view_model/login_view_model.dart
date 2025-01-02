import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/utils/utils.dart';
import 'package:flutter_news_app/features/auth/signup/view/signup_screen.dart';
import 'package:flutter_news_app/features/news_display/view/news_screen.dart';

class LoginViewModel {
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

  void handleLogin({
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
          .signInWithEmailAndPassword(
              email: emailController.text.toString(),
              password: passwordController.text.toString())
          .then(
        (value) {
          emailController.clear();
          passwordController.clear();
          Utils().toastSuccessMessage("Login Successfully");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => NewsScreen(),
            ),
          );
          setLoading(false);
        },
      ).onError(
        (error, stackTrace) {
          Utils().toastErrorMessage(error.toString());
          setLoading(false);
        },
      );
    } else {
      setLoading(false);
      Utils().toastErrorMessage("Invalid Credentials");
    }
  }

  void navigateToSignupScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignupScreen(),
      ),
    );
  }
}
