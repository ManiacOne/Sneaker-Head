import 'package:flutter/material.dart';
import 'package:sneaker_head/baseline.dart';
import 'package:sneaker_head/classify/classify_body.dart';
import 'package:sneaker_head/size_config.dart';

class ClassifyBackground extends StatefulWidget {
  const ClassifyBackground({
    Key? key,
  }) : super(key: key);

  @override
  State<ClassifyBackground> createState() => _ClassifyBackgroundState();
}

class _ClassifyBackgroundState extends State<ClassifyBackground> {
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return 
    Stack(
        children: [
          Positioned(
            height: 50.0*SizeConfig.heightMultiplier,
            child: Container(
            height: size.height,
            width: size.width,
            decoration:const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/classifyBackgrouund.jpg'),
              colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
              fit: BoxFit.cover,
              opacity:0.9
            )
                ),
              ),
          ),
          Positioned(
            top: 40.0*SizeConfig.heightMultiplier,
            //height: 55.0*SizeConfig.heightMultiplier,
            child: Container(
            height: size.height,
            width: size.width,
            decoration:const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40)
               )
              ),
              child: ClassifyBody()
            ),
          ),
          const BaslineSneaker(color: Colors.black,)
        ],
      );
  }
}