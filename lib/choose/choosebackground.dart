import 'package:flutter/material.dart';

class ChooseBackground extends StatelessWidget {
  const ChooseBackground({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: size.height,
        width: size.width,
        decoration:const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/homebackground.jpg'),
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
            fit: BoxFit.cover,
            opacity:0.9
          )
        ),
      ),
    );
  }
}
