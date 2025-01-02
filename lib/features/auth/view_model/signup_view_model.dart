import 'package:flutter/material.dart';

class SignupViewModel {
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
  }) {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      emailController.clear();
      passwordController.clear();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Signup successful"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid credentials"),
        ),
      );
    }
  }

  void navigateToLoginScreen(BuildContext context) {
    Navigator.of(context).pop();
  }
}
