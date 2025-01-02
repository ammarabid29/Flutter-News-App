import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/utils/utils.dart';
import 'package:flutter_news_app/features/auth/login/view/login_screen.dart';
import 'package:flutter_news_app/features/news_display/models/news_channels_headlines_model.dart';
import 'package:flutter_news_app/features/news_display/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelsHeadlinesApi(
      String channelName) async {
    final response = await _rep.fetchNewsChannelsHeadlinesApi(channelName);
    return response;
  }

  void handleLogout(BuildContext context) {
    _auth.signOut().then(
      (value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
        Utils().toastSuccessMessage("Logout Successfully ");
      },
    ).onError(
      (error, stackTrace) {
        Utils().toastErrorMessage(error.toString());
      },
    );
  }
}
