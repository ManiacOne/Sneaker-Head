import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/choose/choose_button.dart';
import 'package:sneaker_head/classify/classify.dart';
import 'package:sneaker_head/discover/discover.dart';
import 'package:sneaker_head/size_config.dart';

class ChooseBody extends StatelessWidget {
  const ChooseBody({
    Key? key,
  }) : super(key: key);
  
  navigatetoclassify(context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  Classify()));
  }

  navigatetodiscover(context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  Discover()));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.5*SizeConfig.widthMultiplier,
                 vertical: 10.0*SizeConfig.heightMultiplier),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text("Hey,\nSneaker Head",
            style: GoogleFonts.ubuntu(
            color: Colors.white,
            fontSize: 6.0*SizeConfig.textMultiplier,
            fontWeight: FontWeight.bold)),
          ),
          SizedBox(height:8.0*SizeConfig.heightMultiplier ),
          Align(
            alignment: Alignment.topLeft,
            child: Text("Please choose your preferred section to continue surfing this application",
             style: GoogleFonts.ubuntu(
              color: Colors.white,
              fontSize: 2.0*SizeConfig.textMultiplier,
              fontWeight: FontWeight.w400
            ),),
          ),
          SizedBox(height:6.0*SizeConfig.heightMultiplier ),
          ChooseButton(headline1: "Find your shoe",
                  headline2: "This option lets you know the name of your shoe with a image of that particular shoe",
                  press: (){navigatetoclassify(context);},
                  ),
          SizedBox(height:3.0*SizeConfig.heightMultiplier ),
          ChooseButton(headline1: "Discover",
                  headline2: "You can surf through all of your favourite shoes in this option",
                  press: (){navigatetodiscover(context);},
                  ),
          ],
        ),
      ),
    );
  }
}

