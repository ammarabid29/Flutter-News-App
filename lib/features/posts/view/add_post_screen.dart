import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/utils/round_button.dart';
import 'package:flutter_news_app/features/auth/widgets/text_form_field_widget.dart';
import 'package:flutter_news_app/features/posts/view_model/post_view_model.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _postViewModel = PostViewModel();

  final _formKey = GlobalKey<FormState>();
  final postController = TextEditingController();

  bool isLoading = false;

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
        "Add Post",
        style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
      ),
    );
  }

  _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 30),
          Form(
            key: _formKey,
            child: TextFormFieldWidget(
              maxLines: 4,
              controller: postController,
              hint: "What's in your mind?",
              icon: Icon(Icons.description),
              validator: (value) {
                return _postViewModel.validatePost(value);
              },
              keyboardType: TextInputType.text,
            ),
          ),
          SizedBox(height: 30),
          RoundButton(
            isLoading: isLoading,
            title: "Add Post",
            onTap: () {
              return _postViewModel.addPost(
                context: context,
                formKey: _formKey,
                postController: postController,
                setLoading: (loading) {
                  setState(() {
                    isLoading = loading;
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
