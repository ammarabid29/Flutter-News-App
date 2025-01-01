import 'package:flutter/material.dart';
import 'package:flutter_news_app/features/home/models/news_channels_headlines_model.dart';
import 'package:flutter_news_app/features/home/view/widgets/card_widget.dart';
import 'package:flutter_news_app/features/home/view_model/news_view_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

enum FiltersList { bbcNews, aryNews, independent, reuters, cnn, alJazeera }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  FiltersList? selectedFilter;

  String channelName = "bbc-news";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.55,
            width: width,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelsHeadlinesApi(channelName),
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
                    scrollDirection: Axis.horizontal,
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
    );
  }

  _buildAppBar() {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        onPressed: () {},
        icon: Image.asset(
          "assets/images/category_icon.png",
          height: 25,
          width: 25,
        ),
      ),
      title: Text(
        "News",
        style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
      ),
      actions: [
        PopupMenuButton<FiltersList>(
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
        )
      ],
    );
  }
}
