import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/utils/round_button.dart';
import 'package:flutter_news_app/features/auth/login/view_model/login_view_model.dart';
import 'package:flutter_news_app/features/auth/widgets/text_form_field_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final phoneNumberController = TextEditingController();

  bool isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        "Login with Phone Number",
        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 50),
            Form(
              key: _formKey,
              child: TextFormFieldWidget(
                controller: phoneNumberController,
                hint: "+1 234 3455 234",
                icon: Icon(Icons.phone),
                validator: (value) {
                  return LoginViewModel().validatePhone(value);
                },
                keyboardType: TextInputType.phone,
              ),
            ),
            SizedBox(height: 60),
            RoundButton(
              isLoading: isLoading,
              title: "Login",
              onTap: () {
                return LoginViewModel().handleLoginWithPhone(
                  formKey: _formKey,
                  context: context,
                  phoneNumberController: phoneNumberController,
                  setLoading: (loading) {
                    isLoading = loading;
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
