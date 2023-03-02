import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/size_config.dart';

class SizeDisplay extends StatefulWidget {
  const SizeDisplay({Key? key, required this.productID}) : super(key: key);
  final String productID;
  @override
  State<SizeDisplay> createState() => _SizeDisplayState();
}

int selectedSizeValue=0; 

class _SizeDisplayState extends State<SizeDisplay> {
  int selectedSize = 0;
  Color selectedSizeColour=Colors.transparent;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Products")
          .where("product_id", isEqualTo: widget.productID)
          .snapshots(),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          return SizedBox(
            height: 5.0 * SizeConfig.heightMultiplier,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: snapShot.data?.docs[0]["size"].length,
                itemBuilder: (BuildContext context, int itemIndex) {
                  return GestureDetector(
                    onTap: () async {
                      setState(() {
                        selectedSize = itemIndex;
                        selectedSizeColour=Color.fromARGB(255, 227, 119, 119);
                        selectedSizeValue =
                            snapShot.data!.docs[0]["size"][itemIndex];
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          right: 2.5 * SizeConfig.widthMultiplier),
                      height: 5.0 * SizeConfig.heightMultiplier,
                      width: 10.0 * SizeConfig.widthMultiplier,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 198, 197, 197),
                          border: Border.all(
                              color: selectedSize == itemIndex
                                  ? selectedSizeColour
                                  : Colors.transparent,
                              width: 3)),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            snapShot.data!.docs[0]["size"][itemIndex]
                                .toString(),
                            style: GoogleFonts.ubuntu(
                                fontSize: 2.0 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  );
                }),
          );
        }
        if (snapShot.hasData && snapShot.data!.docs.isEmpty) {
          return const Text("No sizes available");
        }
        if (snapShot.connectionState == ConnectionState.waiting) {
          return const Text("No sizes available");
        } else {
          return const Text("No sizes available");
        }
      },
    );
  }
}
