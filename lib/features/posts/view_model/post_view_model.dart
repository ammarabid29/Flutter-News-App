import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/utils/utils.dart';
import 'package:flutter_news_app/features/auth/login/view/login_screen.dart';
import 'package:flutter_news_app/features/posts/view/add_post_screen.dart';

class PostViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final databaseRef = FirebaseDatabase.instance.ref("Post");

  void handleLogout(BuildContext context) {
    _auth.signOut().then(
      (value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
        Utils().toastSuccessMessage("Logout Successfully ");
      },
    ).onError(
      (error, stackTrace) {
        Utils().toastErrorMessage(error.toString());
      },
    );
  }

  void navigateToAddPostScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => AddPostScreen(),
      ),
    );
  }

  String? validatePost(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Some Text";
    }
    return null;
  }

  void addPost({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController postController,
    required Function(bool) setLoading,
  }) {
    setLoading(true);
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      databaseRef.child(DateTime.now().microsecondsSinceEpoch.toString()).set({
        "title": postController.text.toString(),
        "id": DateTime.now().microsecondsSinceEpoch.toString(),
      }).then((value) {
        Utils().toastSuccessMessage("Post Added");
        postController.clear();
        Navigator.pop(context);
        setLoading(false);
      }).onError((error, stackTree) {
        Utils().toastErrorMessage("Error in adding post");
        setLoading(false);
      });
    } else {
      setLoading(false);
      Utils().toastSuccessMessage("Invalid Credentials");
    }
  }

}
