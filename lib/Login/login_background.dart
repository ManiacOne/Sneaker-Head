import 'package:flutter/material.dart';

class LoginBackground extends StatefulWidget {
  const LoginBackground({Key? key}) : super(key: key);

  @override
  State<LoginBackground> createState() => _LoginBackgroundState();
}

class _LoginBackgroundState extends State<LoginBackground> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ShaderMask(
                shaderCallback: (rect)=>
                const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.transparent,Colors.black87],
                ).createShader(rect),
                blendMode: BlendMode.darken,
                child: SingleChildScrollView(
                physics:const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  child: Container(
                    height: size.height,
                    width: size.width,
                    decoration:const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/loginbackground.jpg'),
                        colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                        fit: BoxFit.cover,
                        opacity:0.9
                      )
                    ),
                  ),
                )   
                );
              }
}