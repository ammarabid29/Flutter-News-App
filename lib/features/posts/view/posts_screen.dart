import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/features/news_display/view/widgets/card_widget.dart';
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
      body: _buildBody(),
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

  _buildBody() {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: databaseRef.onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: spinKit2,
                );
              } else {
                Map<dynamic, dynamic> map =
                    snapshot.data!.snapshot.value as dynamic;
                List<dynamic> list = [];
                list.clear();
                list = map.values.toList();
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(list[index]["title"]),
                      subtitle: Text(list[index]["id"]),
                    );
                  },
                );
              }
            },
          ),
        ),
        Divider(
          color: Colors.grey,
          thickness: 2,
        ),
        Expanded(
          child: FirebaseAnimatedList(
            query: databaseRef,
            defaultChild: Center(
              child: spinKit2,
            ),
            itemBuilder: (context, snapshot, animation, index) {
              return ListTile(
                title: Text(
                  snapshot.child("title").value.toString(),
                ),
                subtitle: Text(
                  snapshot.child("id").value.toString(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
