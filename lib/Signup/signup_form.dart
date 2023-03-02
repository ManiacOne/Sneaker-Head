import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/Login/login.dart';
import 'package:sneaker_head/custom_button.dart';
import 'package:sneaker_head/size_config.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmpassController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _iscreating = false;
  String email = '';
  String password = '';
  String name = '';
  String phone = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          name_field(),
          email_field(),
          phoneno_field(),
          password_field(),
          confirmpass_field(),
          SizedBox(height: 2.2 * SizeConfig.heightMultiplier),
          Align(
              child: CustomButton(
            buttonText: "Create",
            isloading: _iscreating,
            loadingText: "Creating..",
            press: () async {
              bool validated = this._formkey.currentState?.validate() ?? false;
              if (validated) {
                setState(() {
                  _iscreating = true;
                });
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email, password: password);
                  final User? user = _auth.currentUser;
                  final suserid = user?.uid;
                  await FirebaseFirestore.instance.collection('users').add({
                    'email': email,
                    'name': name,
                    'personal-id': suserid,
                    'image':''
                  });
                  Fluttertoast.showToast(msg: "Account created Successfully");
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Login()));
                } on FirebaseAuthException catch (e) {
                  setState(() {
                    _iscreating = false;
                  });
                  print(e);
                  if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          'Account already exists for this email',
                          style: TextStyle(fontSize: 20.0),
                        )));
                  }
                } catch (e) {
                  print(e);
                }
              }
            },
          )),
        ]
            .map(
              (e) => Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 0.8 * SizeConfig.heightMultiplier),
                child: e,
              ),
            )
            .toList(),
      ),
    );
  }

  TextFormField phoneno_field() {
    return TextFormField(
      style: GoogleFonts.ubuntu(
          fontSize: 2.0 * SizeConfig.textMultiplier, color: Colors.white70),
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan)),
        hintText: 'Enter your phone no.',
        hintStyle: GoogleFonts.ubuntu(
            color: Colors.white54, fontSize: 2.0 * SizeConfig.textMultiplier),
        prefixIcon: Icon(Icons.phone,
            size: 2.5 * SizeConfig.heightMultiplier, color: Colors.white70),
      ),
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      controller: _phoneController,
      onChanged: (value) {
        phone = value.toString();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter phone no.";
        }
      },
    );
  }

  TextFormField confirmpass_field() {
    return TextFormField(
      style: GoogleFonts.ubuntu(
          fontSize: 2.0 * SizeConfig.textMultiplier, color: Colors.white70),
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan)),
        hintText: 'Re-enter your password ',
        hintStyle: GoogleFonts.ubuntu(
            color: Colors.white54, fontSize: 2.0 * SizeConfig.textMultiplier),
        prefixIcon: Icon(Icons.lock_outlined,
            size: 2.5 * SizeConfig.heightMultiplier, color: Colors.white70),
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      controller: _confirmpassController,
      validator: (val) {
        if (val != _passController.text) {
          return 'Passwords donot match';
        }
      },
    );
  }

  TextFormField password_field() {
    return TextFormField(
      style: GoogleFonts.ubuntu(
          fontSize: 2.0 * SizeConfig.textMultiplier, color: Colors.white70),
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan)),
        hintText: 'Enter your password',
        hintStyle: GoogleFonts.ubuntu(
            color: Colors.white54, fontSize: 2.0 * SizeConfig.textMultiplier),
        prefixIcon: Icon(Icons.lock,
            size: 2.5 * SizeConfig.heightMultiplier, color: Colors.white70),
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      obscureText: true,
      controller: _passController,
      onChanged: (value) {
        password = value.toString();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter password";
        }
      },
    );
  }

  TextFormField name_field() {
    return TextFormField(
      style: GoogleFonts.ubuntu(
          fontSize: 2.0 * SizeConfig.textMultiplier, color: Colors.white70),
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan)),
        hintText: 'Enter your Full Name',
        hintStyle: GoogleFonts.ubuntu(
            color: Colors.white54, fontSize: 2.0 * SizeConfig.textMultiplier),
        prefixIcon: Icon(Icons.person,
            size: 2.5 * SizeConfig.heightMultiplier, color: Colors.white70),
      ),
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      controller: _nameController,
      onChanged: (value) {
        name = value.toString();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter name";
        }
      },
    );
  }

  TextFormField email_field() {
    return TextFormField(
      style: GoogleFonts.ubuntu(
          fontSize: 2.0 * SizeConfig.textMultiplier, color: Colors.white70),
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan)),
        hintText: 'Enter your email',
        hintStyle: GoogleFonts.ubuntu(
            color: Colors.white54, fontSize: 2.0 * SizeConfig.textMultiplier),
        prefixIcon: Icon(Icons.email,
            size: 2.5 * SizeConfig.heightMultiplier, color: Colors.white70),
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      controller: _emailController,
      onChanged: (value) {
        email = value.toString();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter email";
        }
      },
    );
  }
}
