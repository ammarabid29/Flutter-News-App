import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/features/firestore/view_model/firestore_view_model.dart';
import 'package:flutter_news_app/features/news_display/view/widgets/card_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class FireStoreListScreen extends StatefulWidget {
  const FireStoreListScreen({super.key});

  @override
  State<FireStoreListScreen> createState() => _FireStoreListScreenState();
}

class _FireStoreListScreenState extends State<FireStoreListScreen> {
  final FirestoreViewModel _firestoreViewModel = FirestoreViewModel();

  final fireStoreSnapshot =
      FirebaseFirestore.instance.collection("users").snapshots();

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
        "FireStore List",
        style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
      ),
      actions: [
        IconButton(
          onPressed: () {
            return _firestoreViewModel.handleLogout(context);
          },
          icon: Icon(Icons.logout),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  _buildBody() {
    return StreamBuilder<QuerySnapshot>(
        stream: fireStoreSnapshot,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: spinKit2,
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                String userId = snapshot.data!.docs[index]["id"].toString();

                return ListTile(
                  onTap: () {
                    // return _firestoreViewModel.updateFireStoreData(id: userId);
                    return _firestoreViewModel.deleteFireStoreData(id: userId);
                  },
                  title: Text(snapshot.data!.docs[index]["title"].toString()),
                  subtitle: Text(userId),
                );
              },
            );
          }
        });
  }

  _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        return _firestoreViewModel.navigateToAddFireStoreDataScreen(context);
      },
      child: Icon(Icons.add),
    );
  }
}
