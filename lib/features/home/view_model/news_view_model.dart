import 'package:flutter_news_app/features/home/models/news_channels_headlines_model.dart';
import 'package:flutter_news_app/features/home/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelsHeadlinesApi(
      String channelName) async {
    final response = await _rep.fetchNewsChannelsHeadlinesApi(channelName);
    return response;
  }

  Future<NewsChannelsHeadlinesModel> fetchAllNewsChannelsHeadlinesApi() async {
    final response = await _rep.fetchAllNewsChannelsHeadlinesApi();
    return response;
  }
}
