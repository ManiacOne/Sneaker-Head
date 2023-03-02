import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/BuyPhase/buy_phase.dart';
import 'package:sneaker_head/size_config.dart';

class CartProductUI extends StatefulWidget {
  const CartProductUI(
      {Key? key,
      required this.productTitle,
      required this.productDescription,
      required this.price,
      required this.size,
      required this.image,
      required this.productID})
      : super(key: key);

  final String productTitle;
  final String productDescription;
  final int price;
  final int size;
  final String image;
  final String productID;

  @override
  State<CartProductUI> createState() => _CartProductUIState();
}

class _CartProductUIState extends State<CartProductUI> {
  onPressRemove() {
    String documentID = '';
    FirebaseFirestore.instance
        .collection('cart')
        .where("product_id", isEqualTo: widget.productID)
        .get()
        .then(
          (QuerySnapshot snapshot) => {
            snapshot.docs.forEach((f) {
              documentID = f.reference.id;
              print(documentID);
              FirebaseFirestore.instance
                  .collection("cart")
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
        height: 59.0 * SizeConfig.heightMultiplier,
        width: 100.0 * SizeConfig.heightMultiplier,
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
                  Text(
                    "Selected Size - ${widget.size} UK",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.ubuntu(
                      fontSize: 2.5 * SizeConfig.textMultiplier,
                      fontWeight: FontWeight.w500,
                    ),
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
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => BuyPhase(
                                      productTitle: widget.productTitle,
                                      productImage: widget.image,
                                      productSize: widget.size,
                                      productPrice: widget.price,
                                    )));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                            onPrimary: Colors.blueGrey,
                            elevation: 3,
                          ),
                          child: Text(
                            "BUY NOW",
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
