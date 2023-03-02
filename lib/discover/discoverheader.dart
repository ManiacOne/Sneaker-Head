import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/image_list.dart';
import 'package:sneaker_head/size_config.dart';

class DiscoverHeader extends StatefulWidget {
  const DiscoverHeader({ Key? key, }) : super(key: key);

  @override
  State<DiscoverHeader> createState() => _DiscoverHeaderState();

}

class _DiscoverHeaderState extends State<DiscoverHeader> {
  @override
  Widget build(BuildContext context) {
    return
     CarouselSlider.builder(
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.98,
                height: 20.0 * SizeConfig.heightMultiplier,
              ),
              itemCount: Images().myimagelist.length,
              itemBuilder:(BuildContext context, int itemIndex, int pageViewIndex) {
                return Container(
                  width: 100.0*SizeConfig.widthMultiplier,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                      image: AssetImage(Images().myimagelist[itemIndex]),
                      colorFilter:const ColorFilter.mode(Colors.black54, BlendMode.darken),
                      fit: BoxFit.cover,
                      opacity:0.8
                      )
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(2.5*SizeConfig.heightMultiplier),
                    child: Text("FIND\nYOUR\nBEST PAIR",
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 4.5*SizeConfig.textMultiplier,
                              fontWeight: FontWeight.bold
                            ),),
                  ),
                );
              });  
  }
}