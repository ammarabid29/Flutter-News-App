import 'package:flutter/material.dart';
import 'package:flutter_news_app/features/news_display/models/all_news_channels_headlines_models.dart';

class ListtileWidget extends StatelessWidget {
  final Sources sources;
  const ListtileWidget({super.key, required this.sources});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade300, // Border color
          width: 1, // Border width
        ),
        borderRadius: BorderRadius.circular(10), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Shadow color
            blurRadius: 4, // Shadow blur radius
            offset: Offset(0, 2), // Shadow offset
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            sources.name != null && sources.name!.isNotEmpty
                ? sources.name![0].toUpperCase()
                : '?',
          ),
        ),
        title: Text(
          sources.name ?? 'No Name',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (sources.description != null && sources.description!.isNotEmpty)
              Text(
                sources.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey),
              ),
            if (sources.category != null) Text('Category: ${sources.category}'),
            if (sources.language != null) Text('Language: ${sources.language}'),
            if (sources.country != null) Text('Country: ${sources.country}'),
          ],
        ),
      ),
    );
  }
}
