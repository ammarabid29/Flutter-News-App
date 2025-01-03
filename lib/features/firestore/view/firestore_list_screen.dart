import 'package:flutter/material.dart';
import 'package:flutter_news_app/features/firestore/view_model/firestore_view_model.dart';
import 'package:google_fonts/google_fonts.dart';

class FireStoreListScreen extends StatefulWidget {
  const FireStoreListScreen({super.key});

  @override
  State<FireStoreListScreen> createState() => _FireStoreListScreenState();
}

class _FireStoreListScreenState extends State<FireStoreListScreen> {
  final FirestoreViewModel _firestoreViewModel = FirestoreViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Ammar"),
          );
        },
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        return _firestoreViewModel.navigateToAddFireStoreDataScreen(context);
      },
      child: Icon(Icons.add),
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
}
