import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/utils/round_button.dart';
import 'package:flutter_news_app/features/auth/login/view_model/login_view_model.dart';
import 'package:flutter_news_app/features/auth/widgets/text_form_field_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        "Verify Phone Number",
        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  final verifyCodeController = TextEditingController();

  bool isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                controller: verifyCodeController,
                hint: "6-digit code",
                icon: Icon(Icons.verified_outlined),
                validator: (value) {
                  return LoginViewModel().validateCode(value);
                },
                keyboardType: TextInputType.phone,
              ),
            ),
            SizedBox(height: 60),
            RoundButton(
              isLoading: isLoading,
              title: "Verify",
              onTap: () {
                return LoginViewModel().verifyCode(
                  context: context,
                  formKey: _formKey,
                  verifyCodeController: verifyCodeController,
                  verificationId: widget.verificationId,
                  setLoading: (loading) {
                    setState(() {
                      isLoading = loading;
                    });
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
