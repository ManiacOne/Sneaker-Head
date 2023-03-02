import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/size_config.dart';

class BaslineSneaker extends StatefulWidget {
  const BaslineSneaker({
    Key? key,
    required this.color
  }) : super(key: key);

  final Color color;

  @override
  State<BaslineSneaker> createState() => _BaslineSneakerState();
}

class _BaslineSneakerState extends State<BaslineSneaker> {
  @override
  Widget build(BuildContext context) {
    return Padding(
     padding: EdgeInsets.only(bottom: 3.0*SizeConfig.heightMultiplier),
     child: Align(
         alignment: Alignment.bottomCenter,
         child: Text("Powered By Sneaker Head",
         style: GoogleFonts.ubuntu(
           color: widget.color,
           fontSize: 2.2*SizeConfig.textMultiplier,
           fontWeight: FontWeight.w700
         ),),
       ),
          );
  }
}