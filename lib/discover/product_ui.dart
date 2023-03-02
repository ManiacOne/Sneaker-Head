import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/Cart/cart_body.dart';
import 'package:sneaker_head/Login/login.dart';
import 'package:sneaker_head/ProductPage/product_page.dart';
import 'package:sneaker_head/Signup/sign_up.dart';
import 'package:sneaker_head/size_config.dart';

class ProductUi extends StatefulWidget {
  const ProductUi(
      {Key? key,
      required this.title,
      required this.price,
      required this.image,
      required this.productID,
      required this.productDescription,
      required this.size})
      : super(key: key);

  final String title;
  final int price;
  final String image;
  final String productID;
  final String productDescription;
  final List size;

  @override
  State<ProductUi> createState() => _ProductUiState();
}

class _ProductUiState extends State<ProductUi> {
  @override
  void initState() {
    // TODO: implement initState
    isFavourite();
    super.initState();
  }

  isFavourite() async {
    var favourite = await FirebaseFirestore.instance
        .collection("wishlist")
        .where("product_id", isEqualTo: widget.productID)
        .where("user_id", isEqualTo: userID)
        .get();
    final List<DocumentSnapshot> docs = favourite.docs;
    if (docs.isNotEmpty) {
      if(FirebaseAuth.instance.currentUser?.uid != null){
        setState(() {
        iconColour = Colors.red;
      });
      }
      else{
        setState(() {
        iconColour = Colors.grey;
      });
      }
      
    }
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  Color iconColour = Colors.grey;

  Future<dynamic> alertforLogin() {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              actions: <Widget>[
                SizedBox(
                  //height: 20.0*SizeConfig.heightMultiplier,
                  width: 80.0 * SizeConfig.widthMultiplier,
                  child: Padding(
                    padding: EdgeInsets.all(2.5 * SizeConfig.heightMultiplier),
                    child: Column(
                      children: [
                        Text(
                          "To wishlist this item you have to first log in to your account",
                          style: GoogleFonts.ubuntu(
                              fontSize: 2.3 * SizeConfig.textMultiplier,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(height: 3.0 * SizeConfig.heightMultiplier),
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SignUp()));
                                },
                                child: Text("SIGNUP",
                                    style: GoogleFonts.ubuntu(
                                        fontSize:
                                            2.2 * SizeConfig.textMultiplier,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.green))),
                            const Spacer(),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Login()));
                                },
                                child: Text("LOGIN",
                                    style: GoogleFonts.ubuntu(
                                        fontSize:
                                            2.2 * SizeConfig.textMultiplier,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.blue)))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ));
  }

  onpressProduct() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProductPage(
              productimage: widget.image,
              productid: widget.productID,
              productdescription: widget.productDescription,
              price: widget.price,
              title: widget.title,
              size: widget.size,
            )));
  }

  onpressWishlistItem() {
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      if (iconColour == Colors.grey) {
        setState(
          () {
            iconColour = Colors.redAccent;
            final User? user = auth.currentUser;
            final userId = user?.uid;
            FirebaseFirestore.instance
                .collection("wishlist")
                .add({'product_id': widget.productID, 'user_id': userId});
            Fluttertoast.showToast(msg: "Added to wishlist");
          },
        );
      } else if (iconColour == Colors.redAccent) {
        setState(
          () {
            iconColour = Colors.grey;
            final User? user = auth.currentUser;
            final userId = user?.uid;
            FirebaseFirestore.instance
                .collection("wishlist")
                .doc(userId)
                .update({
              'wishlisted_items': FieldValue.arrayRemove(
                [widget.productID],
              )
            });
            Fluttertoast.showToast(msg: "Removed from wishlist");
          },
        );
      }
    } else {
      alertforLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onpressProduct(),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1.9,
                    child: Image.network(
                      widget.image,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                            child: Icon(
                          Icons.broken_image,
                          size: 3.5 * SizeConfig.heightMultiplier,
                          color: Colors.black38,
                        ));
                      },
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.black45,
                            backgroundColor: Colors.grey,
                            strokeWidth: 1.5 * SizeConfig.widthMultiplier,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                  //icon press for wishlist
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      splashRadius: 10,
                      onPressed: () {
                        onpressWishlistItem();
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: iconColour,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 1.5 * SizeConfig.heightMultiplier,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 1.5 * SizeConfig.widthMultiplier,
                    right: 1.5 * SizeConfig.widthMultiplier),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(
                        color: Colors.black,
                        height: 0,
                        thickness: 0.8,
                      ),
                      SizedBox(
                        height: 1.0 * SizeConfig.heightMultiplier,
                      ),
                      Text(
                        widget.title,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w700,
                            fontSize: 2.0 * SizeConfig.textMultiplier),
                      ),
                      SizedBox(
                        height: 1.0 * SizeConfig.heightMultiplier,
                      ),
                      Text(
                        "Price :" '${widget.price}',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w800,
                            fontSize: 2.0 * SizeConfig.textMultiplier),
                      ),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
