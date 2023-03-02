import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/categories/categories.dart';
import 'package:sneaker_head/size_config.dart';

class CategoriesUI extends StatefulWidget {
  const CategoriesUI({
    Key? key,
    required this.image, 
    required this.text,
    required this.press
  }) : super(key: key);

    final String image;
    final String text;
    final Function press; 

  @override
  State<CategoriesUI> createState() => _CategoriesUIState();
}

class _CategoriesUIState extends State<CategoriesUI> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: ()=>{
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  Categories(categorytitle: widget.text,)))
    },
    child: Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 1.0*SizeConfig.widthMultiplier,
            left: 0.5*SizeConfig.widthMultiplier),
          child: Container(
            height: SizeConfig.isMobilePortrait==true?15.0*SizeConfig.heightMultiplier:18.0*SizeConfig.heightMultiplier,
            width:60.0*SizeConfig.widthMultiplier,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(widget.image),
                fit: BoxFit.cover,
                colorFilter:const ColorFilter.mode(Colors.black38, BlendMode.darken,)
                )
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0*SizeConfig.heightMultiplier,
              horizontal: 8.0*SizeConfig.widthMultiplier),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(widget.text,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.ubuntu(
                color: Colors.white,
                fontSize: 3.0*SizeConfig.textMultiplier,
                fontWeight: FontWeight.bold
                  )),
            ],
          ),
        ),
          ),
        ),
        
      ],
    ),
    );
  }
}