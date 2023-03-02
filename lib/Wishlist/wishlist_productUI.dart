import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/Wishlist/product_size_display.dart';
import 'package:sneaker_head/size_config.dart';

class WishlistProductUI extends StatefulWidget {
  const WishlistProductUI(
      {Key? key,
      required this.productTitle,
      required this.productDescription,
      required this.price,
      required this.image,
      required this.productID})
      : super(key: key);

  final String productTitle;
  final String productDescription;
  final int price;
  final String productID;
  final String image;

  @override
  State<WishlistProductUI> createState() => _WishlistProductUIState();
}

class _WishlistProductUIState extends State<WishlistProductUI> {
  onPressRemove() {
    String documentID = '';
    FirebaseFirestore.instance
        .collection('wishlist')
        .where("product_id", isEqualTo: widget.productID)
        .get()
        .then(
          (QuerySnapshot snapshot) => {
            snapshot.docs.forEach((f) {
              documentID = f.reference.id;
              FirebaseFirestore.instance
                  .collection("wishlist")
                  .doc(documentID)
                  .delete();
              setState(() {});
            }),
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black12)),
        height: 62.0 * SizeConfig.heightMultiplier,
        width: 95.0 * SizeConfig.heightMultiplier,
        child: Column(
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: SizedBox(
                      height: 30.0 * SizeConfig.heightMultiplier,
                      width: 100.0 * SizeConfig.widthMultiplier,
                      child: Image.network(
                        widget.image,
                        fit: BoxFit.cover,
                      )),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        onPressRemove();
                      },
                      icon: Icon(
                        Icons.delete_forever_sharp,
                        color: Color.fromARGB(255, 211, 56, 45),
                        size: 4.0 * SizeConfig.heightMultiplier,
                      ),
                    ))
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 2.0 * SizeConfig.heightMultiplier,
                  horizontal: 3.0 * SizeConfig.widthMultiplier),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productTitle,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.ubuntu(
                      fontSize: 2.5 * SizeConfig.textMultiplier,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 0.5 * SizeConfig.heightMultiplier,
                  ),
                  Text(
                    widget.productDescription,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.ubuntu(
                      fontSize: 2.2 * SizeConfig.textMultiplier,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 1.0 * SizeConfig.heightMultiplier,
                  ),
                  Text(
                    "${widget.price} RS",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.ubuntu(
                      fontSize: 2.5 * SizeConfig.textMultiplier,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 1.0 * SizeConfig.heightMultiplier,
                  ),
                  Row(
                    children: [
                      Text(
                        "Sizes -",
                        style: GoogleFonts.ubuntu(
                            fontSize: 2.5 * SizeConfig.textMultiplier,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 2.0*SizeConfig.widthMultiplier,),
                         SizeDisplay(productID: widget.productID),
                    ],
                  ),
                  SizedBox(
                    height: 2.2 * SizeConfig.heightMultiplier,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 6.0 * SizeConfig.heightMultiplier,
                      width: 60.0 * SizeConfig.widthMultiplier,
                      child: GestureDetector(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                            onPrimary: Colors.blueGrey,
                            elevation: 3,
                          ),
                          child: Text(
                            "ADD TO CART",
                            style: GoogleFonts.aBeeZee(
                                fontSize: 2.5 * SizeConfig.textMultiplier,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
