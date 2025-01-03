import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/utils/round_button.dart';
import 'package:flutter_news_app/features/auth/widgets/text_form_field_widget.dart';
import 'package:flutter_news_app/features/firestore/view_model/firestore_view_model.dart';
import 'package:google_fonts/google_fonts.dart';

class AddFireStoreDataScreen extends StatefulWidget {
  const AddFireStoreDataScreen({super.key});

  @override
  State<AddFireStoreDataScreen> createState() => _AddFireStoreDataScreenState();
}

class _AddFireStoreDataScreenState extends State<AddFireStoreDataScreen> {
  final _formKey = GlobalKey<FormState>();

  final fireStoreController = TextEditingController();

  final FirestoreViewModel _firestoreViewModel = FirestoreViewModel();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    fireStoreController.dispose();
  }

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
        "Add FireStore Data",
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
              controller: fireStoreController,
              hint: "What's in your mind?",
              icon: Icon(Icons.data_array),
              validator: (value) {
                return _firestoreViewModel.validateFireStoreData(value);
              },
              keyboardType: TextInputType.text,
            ),
          ),
          SizedBox(height: 30),
          RoundButton(
            isLoading: isLoading,
            title: "Add Data",
            onTap: () {
              return _firestoreViewModel.addFireStoreData(
                context: context,
                formKey: _formKey,
                fireStoreController: fireStoreController,
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
