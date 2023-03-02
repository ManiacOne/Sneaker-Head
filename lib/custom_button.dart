import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sneaker_head/size_config.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({Key? key,required this.press, required this.buttonText, required this.loadingText,required this.isloading}) : super(key: key);

  final Function press;
  final String buttonText;
  final String loadingText;
  final bool isloading;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 6.0*SizeConfig.heightMultiplier,
        width: 36.0*SizeConfig.widthMultiplier,
        child:GestureDetector(
          child: ElevatedButton(
            onPressed:()=>widget.press(),
            style: ElevatedButton.styleFrom(
                primary: Colors.cyan,
                onPrimary: Colors.orange,
                elevation: 3,),
            child:
             widget.isloading==false?
             Text(
              widget.buttonText,
              style: GoogleFonts.aBeeZee(
               fontSize: 2.5*SizeConfig.textMultiplier,
               color: Colors.black,fontWeight: FontWeight.bold),
             ):Align(
              alignment: Alignment.topCenter,
               child: JumpingText(widget.loadingText,
               style: GoogleFonts.ubuntu(
                 color:Colors.black,
                 fontSize: 3.5*SizeConfig.textMultiplier,
                 fontWeight: FontWeight.bold
               ),),
             )
             ,
          ),
        ),
      );
  }
}