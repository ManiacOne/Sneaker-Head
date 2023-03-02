import 'package:flutter/material.dart';

class SignupBackground extends StatefulWidget {
  const SignupBackground({Key? key}) : super(key: key);

  @override
  State<SignupBackground> createState() => _SignupBackgroundState();
}

class _SignupBackgroundState extends State<SignupBackground> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ShaderMask(
      shaderCallback: (rect)=>
      const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [Colors.transparent,Colors.black54],
        ).createShader(rect),
        blendMode: BlendMode.darken,
        child: Container(
                height: size.height,
                width: size.width,
                decoration:const BoxDecoration(
                 image: DecorationImage(
                  image: AssetImage('assets/images/signupbackground.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                  opacity: 0.9, )),
            ),
        );
  }
}