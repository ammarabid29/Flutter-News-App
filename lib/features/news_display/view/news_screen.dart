import 'package:flutter/material.dart';
import 'package:flutter_news_app/features/news_display/models/news_channels_headlines_model.dart';
import 'package:flutter_news_app/features/news_display/view/widgets/card_widget.dart';
import 'package:flutter_news_app/features/news_display/view_model/news_view_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

enum FiltersList { bbcNews, aryNews, independent, reuters, cnn, alJazeera }

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final NewsViewModel _newsViewModel = NewsViewModel();

  FiltersList? selectedFilter;

  String channelName = "bbc-news";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        "News",
        style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
      ),
      leading: PopupMenuButton<FiltersList>(
        initialValue: selectedFilter,
        onSelected: (FiltersList item) {
          if (FiltersList.bbcNews.name == item.name) {
            channelName = "bbc-news";
          }
          if (FiltersList.aryNews.name == item.name) {
            channelName = "ary-news";
          }
          if (FiltersList.alJazeera.name == item.name) {
            channelName = "al-jazeera-english";
          }
          setState(() {
            selectedFilter = item;
          });
        },
        icon: Icon(
          Icons.more_vert,
          color: Colors.black,
        ),
        itemBuilder: (ctx) => <PopupMenuEntry<FiltersList>>[
          PopupMenuItem<FiltersList>(
            value: FiltersList.bbcNews,
            child: Text("BBC News"),
          ),
          PopupMenuItem<FiltersList>(
            value: FiltersList.aryNews,
            child: Text("ARY News"),
          ),
          PopupMenuItem<FiltersList>(
            value: FiltersList.alJazeera,
            child: Text("Al Jazeera"),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            return _newsViewModel.handleLogout(context);
          },
          icon: Icon(Icons.logout),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  _buildBody() {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              SizedBox(
                height: height,
                width: width,
                child: FutureBuilder<NewsChannelsHeadlinesModel>(
                  future:
                      _newsViewModel.fetchNewsChannelsHeadlinesApi(channelName),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitCircle(
                          size: 40,
                          color: Colors.blue,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (ctx, index) {
                          return CardWidget(
                            article: snapshot.data!.articles![index],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
