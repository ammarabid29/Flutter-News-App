import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_news_app/core/constants/constants.dart';
import 'package:flutter_news_app/features/news_display/models/news_channels_headlines_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelsHeadlinesApi(
      String channelName) async {
    String url =
        "$newsAPIBaseURL/top-headlines?sources=$channelName&apiKey=$newsAPIKey";

    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    } else {
      throw Exception("error");
    }
  }
}
