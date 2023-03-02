import 'package:flutter/material.dart';
import 'package:sneaker_head/classify/classify_background.dart';

class Classify extends StatefulWidget {
  const Classify({ Key? key }) : super(key: key);

  @override
  State<Classify> createState() => _ClassifyState();
}

class _ClassifyState extends State<Classify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const ClassifyBackground()
    );
  }
}





