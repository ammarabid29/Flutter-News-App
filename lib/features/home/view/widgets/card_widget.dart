import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/features/home/models/news_channels_headlines_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

const spinKit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);

class CardWidget extends StatelessWidget {
  final Articles article;
  const CardWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    final format = DateFormat("MMMM dd, yyyy");
    DateTime dateTime = DateTime.parse(article.publishedAt.toString());

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: width * 0.9,
          height: height * 0.6,
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.02),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: article.urlToImage!,
              fit: BoxFit.cover,
              placeholder: (context, url) => spinKit2,
              errorWidget: (context, url, error) => Icon(
                Icons.error_outline,
                color: Colors.red,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          child: Card(
            elevation: 5,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              alignment: Alignment.bottomCenter,
              height: height * 0.18,
              width: width * 0.7,
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    article.title!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        article.source!.name!,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        format.format(dateTime),
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
