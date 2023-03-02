import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sneaker_head/Cart/cart_productUI.dart';
import 'package:sneaker_head/size_config.dart';

class CartBody extends StatefulWidget {
  const CartBody({Key? key}) : super(key: key);

  @override
  State<CartBody> createState() => _CartBodyState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final userID = user?.uid;

class _CartBodyState extends State<CartBody> {
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
                .collection("cart")
                .where('user_id', isEqualTo: userID)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
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
                            if (snapShot.hasData &&
                                snapShot.data!.docs.isNotEmpty) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: snapShot.data?.docs.length,
                                  itemBuilder: (context, j) {
                                    return CartProductUI(
                                        productTitle: snapShot.data?.docs[j]
                                            ['title'],
                                        productDescription: snapShot
                                            .data?.docs[j]['description'],
                                        price: snapShot.data?.docs[j]['Price'],
                                        size: snapshot.data?.docs[i]
                                            ['selected_size'],
                                        image: snapShot.data?.docs[j]['image'],
                                        productID: snapShot.data?.docs[j]['product_id'],);
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
              if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                return emptydocs();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
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

Padding emptydocs() {
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
      Text("Add Some Items to Cart",
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
