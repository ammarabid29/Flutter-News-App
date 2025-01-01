import 'package:flutter_news_app/features/news_display/models/all_news_channels_headlines_models.dart';
import 'package:flutter_news_app/features/news_display/models/news_channels_headlines_model.dart';
import 'package:flutter_news_app/features/news_display/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelsHeadlinesApi(
      String channelName) async {
    final response = await _rep.fetchNewsChannelsHeadlinesApi(channelName);
    return response;
  }

  Future<AllNewsChannelsHeadlinesModel>
      fetchAllNewsChannelsHeadlinesApi() async {
    final response = await _rep.fetchAllNewsChannelsHeadlinesApi();
    return response;
  }
}
