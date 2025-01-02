import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/features/auth/login/view/login_screen.dart';
import 'package:flutter_news_app/features/news_display/view/news_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) => NewsScreen(),
          ),
        );
      });
    } else {
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) => LoginScreen(),
          ),
        );
      });
    }
  }
}
