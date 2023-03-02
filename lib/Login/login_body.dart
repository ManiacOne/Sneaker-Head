import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/Login/login_form.dart';
import 'package:sneaker_head/Signup/sign_up.dart';
import 'package:sneaker_head/custom_text_button.dart';
import 'package:sneaker_head/size_config.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {

  navigatetosignup(context){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.5*SizeConfig.widthMultiplier,
                 vertical: 15.0*SizeConfig.heightMultiplier),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text("Hey,\nWelcome",
          style: GoogleFonts.ubuntu(
          color: Colors.white,
          fontSize: 6.0*SizeConfig.textMultiplier,
          fontWeight: FontWeight.bold)),
          SizedBox(height:6.0*SizeConfig.heightMultiplier ),
          Text("Please provide your login details to continue",
           style: GoogleFonts.ubuntu(
            color: Colors.white,
            fontSize: 2.2*SizeConfig.textMultiplier,
            fontWeight: FontWeight.w400
          ),),
          SizedBox(height:3.0*SizeConfig.heightMultiplier ),
          const LoginForm(),
          Align(child: CustomTextButton(
            titlebuttontext: "Don't have an Account? SignUp",
            color: Colors.white,
             press:()=>navigatetosignup(context))),
         ],
        ),
      ),
    );
  }
}