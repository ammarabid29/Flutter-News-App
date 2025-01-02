import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/utils/round_button.dart';
import 'package:flutter_news_app/features/auth/view/widgets/text_form_field_widget.dart';
import 'package:flutter_news_app/features/auth/view_model/signup_view_model.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final SignupViewModel _signupViewModel = SignupViewModel();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          height: height * .8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormFieldWidget(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      hint: "Email",
                      icon: Icon(Icons.email_outlined),
                      validator: (value) {
                        return _signupViewModel.validateEmail(value);
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormFieldWidget(
                      obscure: true,
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      hint: "Password",
                      icon: Icon(Icons.password_outlined),
                      validator: (value) {
                        return _signupViewModel.validatePassword(value);
                      },
                    ),
                    const SizedBox(height: 30),
                    RoundButton(
                      title: "Signup",
                      onTap: () {
                        return _signupViewModel.handleSignup(
                          context: context,
                          formKey: _formKey,
                          emailController: emailController,
                          passwordController: passwordController,
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            return _signupViewModel
                                .navigateToLoginScreen(context);
                          },
                          child: Text(
                            "Login",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        "Signup",
        style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
      ),
    );
  }
}
