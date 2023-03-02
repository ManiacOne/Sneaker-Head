import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/size_config.dart';

class ClassifyButton extends StatefulWidget {
  const ClassifyButton({ 
    required this.press,
    required this.icon,
    required this.color,
    required this.buttonName,

   Key? key}) : super(key: key);


   final Function press;
   final IconData icon;
   final Color color;
   final String buttonName;

  @override
  State<ClassifyButton> createState() => _ClassifyButtonState();
}

class _ClassifyButtonState extends State<ClassifyButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: 10.0*SizeConfig.heightMultiplier,
            child: OutlinedButton(
              onPressed: ()=>widget.press(),
              style: OutlinedButton.styleFrom(
                  shape: const CircleBorder(),
                  shadowColor: Colors.black,
                  primary: Colors.blue 
                ),
              child: Icon(widget.icon,
                      color: widget.color,
                      size: 5.0*SizeConfig.heightMultiplier,),
              ),
             ),
          SizedBox(height: 1.5*SizeConfig.heightMultiplier,),
          Text(widget.buttonName,
                style: GoogleFonts.ubuntu(
                  fontSize: 1.9*SizeConfig.textMultiplier,
                  color: Colors.black,
                  fontWeight: FontWeight.w800
                ),)
        ],
      ),
    );
  }
}