import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/Login/login.dart';
import 'package:sneaker_head/Signup/signup_form.dart';
import 'package:sneaker_head/custom_text_button.dart';
import 'package:sneaker_head/size_config.dart';

class SignupBody extends StatefulWidget {
  const SignupBody({Key? key}) : super(key: key);

  @override
  State<SignupBody> createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody> {

  navigatetologin(context){
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0*SizeConfig.heightMultiplier,
        horizontal: 3.5*SizeConfig.widthMultiplier),
      child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text("Get Started,",
           style: GoogleFonts.ubuntu(
             color: Colors.white,
             fontWeight: FontWeight.bold,
             fontSize: 5.0*SizeConfig.textMultiplier)),
           SizedBox(height: 3.0*SizeConfig.heightMultiplier),
           Text("Lets sign you up",
           style: GoogleFonts.ubuntu(
             color: Colors.white,
             fontWeight: FontWeight.bold,
             fontSize: 2.2*SizeConfig.textMultiplier)),
           SizedBox(height: 2.5*SizeConfig.heightMultiplier), 
           const SignupForm(),
           SizedBox(height: 0.0*SizeConfig.heightMultiplier), 
           Align(child: CustomTextButton(
             titlebuttontext: "Already have an Account?Login",
             color: Colors.white,
              press:()=>navigatetologin(context)))
         ],
       ),
    );
  }
}