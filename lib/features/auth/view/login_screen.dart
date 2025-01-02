import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/utils/round_button.dart';
import 'package:flutter_news_app/features/auth/view/widgets/text_form_field_widget.dart';
import 'package:flutter_news_app/features/auth/view_model/login_view_model.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final LoginViewModel _loginViewModel = LoginViewModel();

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
                    Image.asset(
                      "assets/images/splash_pic.jpg",
                      fit: BoxFit.cover,
                      height: height * .3,
                    ),
                    TextFormFieldWidget(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      hint: "Email",
                      icon: Icon(Icons.email_outlined),
                      validator: (value) {
                        return _loginViewModel.validateEmail(value);
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
                        return _loginViewModel.validatePassword(value);
                      },
                    ),
                    const SizedBox(height: 30),
                    RoundButton(
                      title: "Login",
                      onTap: () {
                        return _loginViewModel.handleLogin(
                          context: context,
                          formKey: _formKey,
                          emailController: emailController,
                          passwordController: passwordController,
                        );
                      },
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
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        "Login",
        style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
      ),
    );
  }
}
