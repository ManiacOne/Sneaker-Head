import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sneaker_head/discover/product_ui.dart';
import 'package:sneaker_head/size_config.dart';

class ShowFeatured extends StatefulWidget {
  const ShowFeatured({ Key? key }) : super(key: key);

  @override
  State<ShowFeatured> createState() => _ShowFeaturedState();
}

class _ShowFeaturedState extends State<ShowFeatured> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("Products")
                    .where("isFeatured",isEqualTo: true)
                    .snapshots(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return nodata();
                      }
                      if(snapshot.hasData&&snapshot.data!.docs.isEmpty){
                        return emptydocs();
                      }
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return connectionwaiting();
                      }
                      else{
                        return Padding(
                          padding: EdgeInsets.only(
                            left: 1.2*SizeConfig.widthMultiplier,
                            right: 1.2*SizeConfig.widthMultiplier),
                          child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:2,
                                crossAxisSpacing: 2.0*SizeConfig.widthMultiplier,
                                mainAxisSpacing: 2.0*SizeConfig.heightMultiplier,
                                childAspectRatio: SizeConfig.isMobilePortrait==true?0.13*SizeConfig.heightMultiplier:
                                                  0.107*SizeConfig.heightMultiplier,
                                ),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, i){
                                  return ProductUi(
                                    image: snapshot.data!.docs[i]["image"],
                                    title: snapshot.data!.docs[i]["title"],
                                    price: snapshot.data!.docs[i]["Price"],
                                    productID: snapshot.data!.docs[i]["product_id"],
                                    productDescription: snapshot.data!.docs[i]["description"],
                                    size: snapshot.data!.docs[i]["size"],
                                  );
                                 } 
                            ),
                        );
                      }
                    }
                  );
  }
}

Padding connectionwaiting() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.0*SizeConfig.heightMultiplier),
      child: JumpingDotsProgressIndicator(
             fontSize: 5.5*SizeConfig.textMultiplier,
             numberOfDots: 5,
             color: Colors.black,
           ),
    );
  }

  Padding emptydocs() {
    return Padding(
           padding: EdgeInsets.symmetric(vertical: 4.0*SizeConfig.heightMultiplier),
           child: Align(
                  child: Column(children:[
                    Text("Sorry!\nNo Featured items Available",
                        textAlign:TextAlign.center,
                        style: GoogleFonts.ubuntu(
                          fontSize: 2.0*SizeConfig.textMultiplier,
                          fontWeight: FontWeight.w400
                        )),    
                    SizedBox(
                    height: 20.0*SizeConfig.heightMultiplier,
                    width: 50.0*SizeConfig.widthMultiplier,
                      child:const Image(image: AssetImage("assets/images/noData.webp"),
                      fit: BoxFit.cover)
                    ),
                  ]),
              ),
           );
  }

  Padding nodata() {
    return Padding(
           padding: EdgeInsets.symmetric(vertical: 4.0*SizeConfig.heightMultiplier),
           child: Align(
                  child: Column(children:[
                    Text("Sorry!\nNo items Available",
                        textAlign:TextAlign.center,
                        style: GoogleFonts.ubuntu(
                          fontSize: 2.0*SizeConfig.textMultiplier,
                          fontWeight: FontWeight.w400
                        )),    
                    SizedBox(
                    height: 20.0*SizeConfig.heightMultiplier,
                    width: 50.0*SizeConfig.widthMultiplier,
                      child:const Image(image: AssetImage("assets/images/notAvailable.webp"),
                      fit: BoxFit.cover)
                    ),
                  ]),
              ),
           );
  }