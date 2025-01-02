import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/features/posts/view_model/post_view_model.dart';
import 'package:google_fonts/google_fonts.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final _postViewModel = PostViewModel();

  final databaseRef = FirebaseDatabase.instance.ref("Post");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        "Posts",
        style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
      ),
      actions: [
        IconButton(
          onPressed: () {
            return _postViewModel.handleLogout(context);
          },
          icon: Icon(Icons.logout),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        return _postViewModel.navigateToAddPostScreen(context);
      },
      child: Icon(Icons.add),
    );
  }
}
