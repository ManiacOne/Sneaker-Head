import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/Signup/signup_background.dart';
import 'package:sneaker_head/Signup/signup_body.dart';
import 'package:sneaker_head/size_config.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Sign Up",
        style: GoogleFonts.ubuntu(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 2.5*SizeConfig.textMultiplier)),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children:const [
             SignupBackground(),
             SignupBody()
          ],),
      ),
    );
  }
}