import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/utils/utils.dart';
import 'package:flutter_news_app/features/auth/login/view/login_with_phone_number.dart';
import 'package:flutter_news_app/features/auth/login/view/verify_code_screen.dart';
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

  void navigateToLoginWithPhoneScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginWithPhoneNumber(),
      ),
    );
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Phone Number";
    }
    return null;
  }

  void handleLoginWithPhone({
    required BuildContext context,
    required TextEditingController phoneNumberController,
    required Function(bool) setLoading,
    required GlobalKey<FormState> formKey,
  }) {
    setLoading(true);
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      _auth.verifyPhoneNumber(
        phoneNumber: phoneNumberController.text.toString(),
        verificationCompleted: (_) {
          setLoading(false);
        },
        verificationFailed: (error) {
          Utils().toastErrorMessage(error.toString());
          setLoading(false);
        },
        codeSent: (String verificationId, int? token) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => VerifyCodeScreen(
                verificationId: verificationId,
              ),
            ),
          );
          setLoading(false);
        },
        codeAutoRetrievalTimeout: (error) {
          Utils().toastErrorMessage(error.toString());
          setLoading(false);
        },
      );
    } else {
      Utils().toastErrorMessage("Invalid Credentials");
      setLoading(false);
    }
  }

  String? validateCode(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Verification Code";
    }
    return null;
  }

  void verifyCode({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController verifyCodeController,
    required String verificationId,
    required Function(bool) setLoading,
  }) async {
    setLoading(true);
    FocusScope.of(context).unfocus();

    final credentials = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: verifyCodeController.text.toString(),
    );
    if (formKey.currentState!.validate()) {
      try {
        await _auth.signInWithCredential(credentials);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => NewsScreen(),
          ),
        );
        setLoading(false);
      } catch (e) {
        setLoading(false);
        Utils().toastErrorMessage(e.toString());
      }
    } else {
      Utils().toastErrorMessage("Invalid Credentials");
      setLoading(false);
    }
  }
}
