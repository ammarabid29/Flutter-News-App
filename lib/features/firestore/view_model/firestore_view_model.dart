import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/utils/utils.dart';
import 'package:flutter_news_app/features/auth/login/view/login_screen.dart';
import 'package:flutter_news_app/features/firestore/view/add_firestore_data.dart';

class FirestoreViewModel {
  final _auth = FirebaseAuth.instance;

  final fireStoreCollection = FirebaseFirestore.instance.collection("users");

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

  void navigateToAddFireStoreDataScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => AddFireStoreDataScreen(),
      ),
    );
  }

  String? validateFireStoreData(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Some Text";
    }
    return null;
  }

  void addFireStoreData({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController fireStoreController,
    required Function(bool) setLoading,
  }) {
    setLoading(true);
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      String id = DateTime.now().microsecondsSinceEpoch.toString();

      fireStoreCollection.doc(id).set({
        "title": fireStoreController.text.toString(),
        "id": id,
      }).then((value) {
        setLoading(false);
        Utils().toastSuccessMessage("Data added.");
        fireStoreController.clear();
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils().toastErrorMessage(error.toString());
      });
    } else {
      setLoading(false);
      Utils().toastErrorMessage("Invalid Credentials");
    }
  }

  void updateFireStoreData({required String id}) {
    fireStoreCollection.doc(id).update(
      {"title": "user updated"},
    ).then((value) {
      Utils().toastSuccessMessage("User Updated");
    }).onError((error, stackTree) {
      Utils().toastErrorMessage("Error in updating user");
    });
  }

  void deleteFireStoreData({required String id}) {
    fireStoreCollection.doc(id).delete().then((value) {
      Utils().toastSuccessMessage("User Deleted");
    }).onError((error, stackTree) {
      Utils().toastErrorMessage("Error in deleting user");
    });
  }
}
