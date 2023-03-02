import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/size_config.dart';

class CustomTextButton extends StatefulWidget {
  const CustomTextButton({
    Key? key,
    required this.titlebuttontext,
    required this.press,
    required this.color,
    }) : super(key: key);

  final String titlebuttontext;
  final Function press;
  final Color color;

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
        return 
       TextButton(onPressed:()=>widget.press(),
       child:
           Text(widget.titlebuttontext,
           style: GoogleFonts.ubuntu(
             color: widget.color,
             fontWeight: FontWeight.w600,
             fontSize: 2.0*SizeConfig.textMultiplier
           ),),
    );
  }
}