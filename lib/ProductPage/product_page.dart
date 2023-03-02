import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sneaker_head/Login/login.dart';
import 'package:sneaker_head/ProductPage/product_image.dart';
import 'package:sneaker_head/ProductPage/product_size_display.dart';
import 'package:sneaker_head/Signup/sign_up.dart';
import 'package:sneaker_head/custom_text_button.dart';
import 'package:sneaker_head/size_config.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    Key? key,
    required this.productimage,
    required this.productid,
    required this.productdescription,
    required this.title,
    required this.price,
    required this.size,
  }) : super(key: key);

  final String productimage;
  final String productid;
  final String productdescription;
  final String title;
  final int price;
  final List size;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

bool isExpanded = false;
bool isloading = false;

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    int selectedImage = 0;

    final FirebaseAuth _auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.ubuntu(
              color: Colors.black, fontWeight: FontWeight.w500),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: NoGlowScroll(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 0.0 * SizeConfig.heightMultiplier),
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Product Images")
                        .where("product_id", isEqualTo: widget.productid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return nodata();
                      }
                      if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                        return emptydocs();
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return connectionwaiting();
                      } else {
                        return ProductImages(
                            selectedImage: selectedImage, snapshot: snapshot);
                      }
                    }),
                Container(
                  margin: EdgeInsets.only(
                      bottom: 1.0 * SizeConfig.heightMultiplier),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 226, 226, 226),
                          Color.fromARGB(255, 243, 241, 241),
                          Colors.white
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Padding(
                    padding: EdgeInsets.all(2.5 * SizeConfig.heightMultiplier),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title(),
                        SizedBox(
                          height: 2.0 * SizeConfig.heightMultiplier,
                        ),
                        prices(),
                        SizedBox(
                          height: 2.0 * SizeConfig.heightMultiplier,
                        ),
                        sizes(),
                        SizedBox(
                          height: 2.0 * SizeConfig.heightMultiplier,
                        ),
                        productDescription(),
                        showMoreandLessButton(),
                        SizedBox(
                          height: 1.5 * SizeConfig.heightMultiplier,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 65.0 * SizeConfig.widthMultiplier,
                            height: 7.0 * SizeConfig.heightMultiplier,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (FirebaseAuth.instance.currentUser?.uid ==
                                    null) {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                            actions: <Widget>[
                                              SizedBox(
                                                width: 80.0 *
                                                    SizeConfig.widthMultiplier,
                                                child: Padding(
                                                  padding: EdgeInsets.all(2.5 *
                                                      SizeConfig
                                                          .heightMultiplier),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "To add this item you have to first log in to your account",
                                                        style: GoogleFonts.ubuntu(
                                                            fontSize: 2.3 *
                                                                SizeConfig
                                                                    .textMultiplier,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                      SizedBox(
                                                          height: 3.0 *
                                                              SizeConfig
                                                                  .heightMultiplier),
                                                      Row(
                                                        children: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .push(MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                SignUp()));
                                                              },
                                                              child: Text(
                                                                  "SIGNUP",
                                                                  style: GoogleFonts.ubuntu(
                                                                      fontSize: 2.2 *
                                                                          SizeConfig
                                                                              .textMultiplier,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      color: Colors
                                                                          .green))),
                                                          const Spacer(),
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .push(MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                Login()));
                                                              },
                                                              child: Text(
                                                                  "LOGIN",
                                                                  style: GoogleFonts.ubuntu(
                                                                      fontSize: 2.2 *
                                                                          SizeConfig
                                                                              .textMultiplier,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      color: Colors
                                                                          .blue)))
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ));
                                } else {
                                  if (selectedSizeValue == 0) {
                                    Fluttertoast.showToast(
                                        msg: "Select Size First");
                                  } else {
                                    final User? user = _auth.currentUser;
                                    final userID = user?.uid;
                                    await FirebaseFirestore.instance
                                        .collection('cart')
                                        .add({
                                      'product_id': widget.productid,
                                      'user_id': userID,
                                      'selected_size': selectedSizeValue
                                    });
                                    Fluttertoast.showToast(
                                        msg: "Added to cart succesfully");
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                  onPrimary: Colors.orange,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: isloading == false
                                  ? Text(
                                      "Add to Cart",
                                      style: GoogleFonts.ubuntu(
                                          fontSize:
                                              2.6 * SizeConfig.textMultiplier,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Row(
                                      children: [
                                        JumpingText(
                                          "Adding...",
                                          style: GoogleFonts.ubuntu(
                                              color: Colors.black,
                                              fontSize: 2.5 *
                                                  SizeConfig.textMultiplier,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CustomTextButton showMoreandLessButton() {
    return CustomTextButton(
        titlebuttontext: isExpanded == true ? "show less" : "show more",
        press: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        color: Colors.black);
  }

  Text title() {
    return Text(
      widget.title,
      style: GoogleFonts.ubuntu(
          fontSize: 3.0 * SizeConfig.textMultiplier,
          fontWeight: FontWeight.bold),
    );
  }

  Text prices() {
    return Text(
      '${widget.price}' " Rs",
      style: GoogleFonts.ubuntu(
          fontSize: 3.0 * SizeConfig.textMultiplier,
          fontWeight: FontWeight.w700),
    );
  }

  Row sizes() {
    return Row(
      children: [
        Text(
          "Sizes -",
          style: GoogleFonts.ubuntu(
              fontSize: 2.5 * SizeConfig.textMultiplier,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 2.0 * SizeConfig.widthMultiplier,
        ),
        ProductSizesDisplay(widget: widget)
      ],
    );
  }

  Text productDescription() {
    return Text(
      widget.productdescription,
      overflow: isExpanded == true ? null : TextOverflow.ellipsis,
      maxLines: isExpanded == true ? 50 : 7,
      style: GoogleFonts.ubuntu(
          fontSize: 2.2 * SizeConfig.textMultiplier,
          fontWeight: FontWeight.w400),
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
    padding: EdgeInsets.symmetric(vertical: 4.0 * SizeConfig.heightMultiplier),
    child: Align(
      child: Column(children: [
        Text("Sorry!\nNo Featured items Available",
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

Padding nodata() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0 * SizeConfig.heightMultiplier),
    child: Align(
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
                image: AssetImage("assets/images/notAvailable.webp"),
                fit: BoxFit.cover)),
      ]),
    ),
  );
}
