import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/size_config.dart';

class ChooseButton extends StatefulWidget {
  const ChooseButton({
    required this.headline1,
    required this.headline2,
    required this.press,
     Key? key }) : super(key: key);

  final String headline1;
  final String headline2;
  final Function press;
  @override
  _ChooseButtonState createState() => _ChooseButtonState();
}

class _ChooseButtonState extends State<ChooseButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>widget.press(),
      child: Container(
        height: SizeConfig.isMobilePortrait==true?18.0*SizeConfig.heightMultiplier
                :18.0*SizeConfig.heightMultiplier,
        width:100.0*SizeConfig.widthMultiplier,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white54
        ),
        child: Column(
           children:<Widget> [
             Flexible(
               child: Padding(
                 padding: EdgeInsets.only(
                    top: 2.0*SizeConfig.heightMultiplier,
                    left: 2.0*SizeConfig.heightMultiplier,
                    right: 2.0*SizeConfig.heightMultiplier),
                 child: Align(
                   alignment: Alignment.topLeft,
                   child: Text(
                    widget.headline1,
                    style: GoogleFonts.roboto(
                     fontSize: 3.0*SizeConfig.textMultiplier,
                     color: Colors.black,fontWeight: FontWeight.bold),
                   ),
                 ),
               ),
             ),
             Flexible(
               child: Padding(
                 padding: EdgeInsets.only(
                    bottom: 2.0*SizeConfig.heightMultiplier,
                    left: 2.0*SizeConfig.heightMultiplier,
                    right: 2.0*SizeConfig.heightMultiplier),
                 child: Align(
                   alignment: Alignment.bottomLeft,
                   child: Text(
                    widget.headline2,
                    style: GoogleFonts.roboto(
                     fontSize: 1.8*SizeConfig.textMultiplier,
                     color: Colors.black,fontWeight: FontWeight.bold),
                   ),
                 ),
               ),
             ),
           ],
         ),
      ),
    );
  }
}