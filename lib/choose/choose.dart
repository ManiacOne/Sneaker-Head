import 'package:flutter/material.dart';
import 'package:sneaker_head/baseline.dart';
import 'package:sneaker_head/choose/choose_body.dart';
import 'package:sneaker_head/choose/choosebackground.dart';
class Choose extends StatefulWidget {
  const Choose({ Key? key }) : super(key: key);

  @override
  _ChooseState createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Scaffold(
     body: GestureDetector(
       child: Stack(
         children:[
          ChooseBackground(size: size),
          const ChooseBody(),
          const BaslineSneaker(color: Colors.white,)
         ],
       ),
     ),
    );
  }
}