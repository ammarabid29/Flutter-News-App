import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_news_app/features/auth/view/login_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
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
