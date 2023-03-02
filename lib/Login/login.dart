import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/Login/login_background.dart';
import 'package:sneaker_head/Login/login_body.dart';
import 'package:sneaker_head/size_config.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Sign In",
        style: GoogleFonts.ubuntu(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 2.5*SizeConfig.textMultiplier)),
      ),
     body: GestureDetector(
       child: Stack(
         children:[
          LoginBackground(),
          const LoginBody()
         ],
       ),
     ),
    );
  }
}