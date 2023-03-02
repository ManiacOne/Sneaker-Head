import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/custom_button.dart';
import 'package:sneaker_head/custom_text_button.dart';
import 'package:sneaker_head/discover/discover.dart';
import 'package:sneaker_head/size_config.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _formkey=GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool isObscure=true;
  String errorMessage='';
  bool _isloging = false;

   void changeObscure() {
    return setState(() {
                        isObscure=!isObscure;
                      });
  }

  onpressLogin(context)async{
     if( _formkey.currentState!.validate()){
       firebaseAuth();
     }
     else{return;}
  }

  firebaseAuth()async{
    try{
        setState(() {
          _isloging=true;
        });
        await FirebaseAuth.instance.signInWithEmailAndPassword
        (email: _emailController.text,
        password: _passController.text).then((value) => {
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(
        builder: 
        (BuildContext context)
         => Discover()))
        });
      }
     on FirebaseAuthException catch(error){
       setState(() {
         _isloging=false;
       });
       switch(error.code){
                case "invalid-email":
                  errorMessage = "Your email address appears to be malformed.";
                   Fluttertoast.showToast(
                     msg: "invalid-email",
                     backgroundColor: Colors.white,
                     fontSize: 2.0*SizeConfig.textMultiplier,
                     gravity: ToastGravity.BOTTOM, 
                     textColor: Colors.black);
                  break;

                case "wrong-password":
                   errorMessage = "Your password is wrong.";
                   Fluttertoast.showToast(
                     msg: "incorrect email or password",
                     backgroundColor: Colors.white,
                     fontSize: 2.0*SizeConfig.textMultiplier,
                     gravity: ToastGravity.BOTTOM, 
                     textColor: Colors.black);
                   break;

                case "user-not-found":
                      errorMessage = "User with this email doesn't exist.";
                     Fluttertoast.showToast(
                       msg: "incorrect email or password",
                       backgroundColor: Colors.white,
                       fontSize: 2.0*SizeConfig.textMultiplier,
                       gravity: ToastGravity.BOTTOM, 
                       textColor: Colors.black);
                    break;
                case "user-disabled":
                      errorMessage = "User with this email has been disabled.";
                     Fluttertoast.showToast(
                       msg: "user is disabled",
                       backgroundColor: Colors.white,
                       fontSize: 2.0*SizeConfig.textMultiplier,
                       gravity: ToastGravity.BOTTOM, 
                       textColor: Colors.black);
                      
                      break;
                case "too-many-requests":
                      errorMessage = "Too many requests";
                       Fluttertoast.showToast(
                       msg: "too many requests",
                       backgroundColor: Colors.white,
                       fontSize: 2.0*SizeConfig.textMultiplier,
                       gravity: ToastGravity.BOTTOM, 
                       textColor: Colors.black);
                      
                      break;
                case "operation-not-allowed":
                      errorMessage = "Signing in with Email and Password is not enabled.";
                     Fluttertoast.showToast(
                       msg: 'Signing in with Email and Password not enabled.',
                       backgroundColor: Colors.white,
                       fontSize: 2.0*SizeConfig.textMultiplier,
                       gravity: ToastGravity.BOTTOM, 
                       textColor: Colors.black);
                      break;
                default:
                      errorMessage = "An undefined Error happened.";
                      Fluttertoast.showToast(
                        msg: "Undefined Error",
                        backgroundColor: Colors.white,
                        fontSize: 2.0*SizeConfig.textMultiplier,
                        gravity: ToastGravity.BOTTOM,
                        textColor: Colors.black);
              }
         }
  }

  onpressforgot(){
   // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const ForgotpassPage()));
  }


  @override
  Widget build(BuildContext context) {
   return Column(
      children:[
         Form(
          key: _formkey,
          child: Column(children:[
          emailField(),
          SizedBox(height: 1.5*SizeConfig.heightMultiplier),
          passwordField(),
          ])),
          Align(alignment:Alignment.topRight,
          child: CustomTextButton(
           titlebuttontext: "Forgot Password?",
           color: Colors.white,
            press: ()=>onpressforgot()
            )),
         SizedBox(height: 5.0*SizeConfig.heightMultiplier),
         CustomButton(
          buttonText: "Login",
          press: ()=>onpressLogin(context),
          loadingText: "......",
          isloading: _isloging,
          )
      ]
    );
  }


  TextFormField passwordField() {
    return TextFormField(
              style: GoogleFonts.ubuntu(
                fontSize: 2.0*SizeConfig.textMultiplier,color: Colors.white),
              obscureText: isObscure,
              controller: _passController,
              onChanged: (value) {
                value=_passController.text.trim();
              },
              validator: (value) {
                if(value!.isEmpty){
                  return 'Please enter password';
                }
              },
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                border:const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
                focusedBorder:const OutlineInputBorder(
                  borderSide:BorderSide(color: Colors.cyan)),
                enabledBorder:const OutlineInputBorder(
                  borderSide:BorderSide(color: Colors.white70)),
                hintText: 'Provide Password',
                hintStyle: TextStyle(color: Colors.white70,
                          fontSize: 2.0*SizeConfig.textMultiplier),
                prefixIcon: Icon(Icons.lock,
                  size: 2.5*SizeConfig.heightMultiplier,color: Colors.white70,),
                suffixIcon:IconButton(
                  onPressed: () {
                      changeObscure();},
                  icon: isObscure?Icon(Icons.visibility_off,
                    size: 2.5*SizeConfig.heightMultiplier,color: Colors.white70,):
                    Icon(Icons.visibility,
                    size: 2.5*SizeConfig.heightMultiplier,color: Colors.white70,)
                ),
              ),
            );
  }

  TextFormField emailField() {
    return TextFormField(
          style: GoogleFonts.ubuntu(
            fontSize: 2.0*SizeConfig.textMultiplier,color: Colors.white),
          controller: _emailController,
          onChanged: (value) {
            value=_emailController.text.trim();
          },
          validator: (value) {
                if(value!.isEmpty){
                  return 'Please enter email';
                }},
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border:const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
            focusedBorder:const OutlineInputBorder(
              borderSide:BorderSide(color: Colors.cyan)),
            enabledBorder:const OutlineInputBorder(
              borderSide:BorderSide(color: Colors.white70)),
            hintText: 'Enter Email',
            hintStyle: TextStyle(color: Colors.white70,
                      fontSize: 2.0*SizeConfig.textMultiplier),
            prefixIcon: Icon(Icons.email,
              size: 2.5*SizeConfig.heightMultiplier,color: Colors.white70,),
          ),
        );
  }
}


