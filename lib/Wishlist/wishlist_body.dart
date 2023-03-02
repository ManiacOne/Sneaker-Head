import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sneaker_head/Wishlist/wishlist_productUI.dart';
import 'package:sneaker_head/size_config.dart';

class Wishlistbody extends StatefulWidget {
  const Wishlistbody({Key? key}) : super(key: key);

  @override
  State<Wishlistbody> createState() => _WishlistbodyState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final userID = user?.uid;

class _WishlistbodyState extends State<Wishlistbody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics:
          const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 2.0 * SizeConfig.widthMultiplier),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("wishlist")
                .where('user_id', isEqualTo: userID)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData&& snapshot.data!.docs.isNotEmpty) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, i) {
                      return StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("Products")
                              .where('product_id',
                                  isEqualTo: snapshot.data?.docs[i]
                                      ['product_id'])
                              .snapshots(),
                          builder: (context, snapShot) {
                            if (snapShot.hasData) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: snapShot.data?.docs.length,
                                  itemBuilder: (context, j) {
                                    return WishlistProductUI(
                                        productTitle: snapShot.data?.docs[j]
                                            ['title'],
                                        productDescription: snapShot
                                            .data?.docs[j]['description'],
                                        price: snapShot.data?.docs[j]['Price'],
                                        productID: snapShot.data?.docs[j]
                                            ['product_id'],
                                        image: snapShot.data?.docs[j]['image']);
                                  });
                            }
                            if (snapShot.hasData &&
                                snapShot.data!.docs.isEmpty) {
                              return emptydocs();
                            }
                            if (snapShot.connectionState ==
                                ConnectionState.waiting) {
                              return connectionwaiting();
                            } else {
                              return nodata();
                            }
                          });
                    });
              }
              else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                return emptydocs();
              }
              else if (snapshot.connectionState == ConnectionState.waiting) {
                return connectionwaiting();
              } else {
                return nodata();
              }
            }),
      ),
    );
  }
}

Padding connectionwaiting() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0 * SizeConfig.heightMultiplier),
    child: JumpingDotsProgressIndicator(
      fontSize: 5.5 * SizeConfig.textMultiplier,
      numberOfDots: 5,
      color: Colors.black,
    ),
  );
}

 emptydocs() {
  return Padding(
    padding:  EdgeInsets.only(top:10.0*SizeConfig.heightMultiplier),
    child: Column(
      children: [
      Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: const [
           Image(
              image: AssetImage("assets/images/notAvailable.webp"),
              fit: BoxFit.contain),
        ],
      ),
      Text("No Wishlisted Item",
          textAlign: TextAlign.center,
          style: GoogleFonts.hindSiliguri(
              fontSize: 2.5 * SizeConfig.textMultiplier,
              fontWeight: FontWeight.w600)),
    ]),
  );
}

Padding nodata() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0 * SizeConfig.heightMultiplier),
    child: Align(
      alignment: Alignment.center,
      child: Column(children: [
        Text("Sorry!\nNo items Available",
            textAlign: TextAlign.center,
            style: GoogleFonts.ubuntu(
                fontSize: 2.0 * SizeConfig.textMultiplier,
                fontWeight: FontWeight.w400)),
        SizedBox(
            height: 20.0 * SizeConfig.heightMultiplier,
            width: 50.0 * SizeConfig.widthMultiplier,
            child: const Image(
                image: AssetImage("assets/images/noData.webp"),
                fit: BoxFit.cover)),
      ]),
    ),
  );
}
