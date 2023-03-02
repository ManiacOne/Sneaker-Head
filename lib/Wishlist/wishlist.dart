import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/Wishlist/wishlist_body.dart';
import 'package:sneaker_head/size_config.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          "My WIshlist",
          style: GoogleFonts.ubuntu(
            fontSize: 2.5*SizeConfig.textMultiplier,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
      ),
      body: Wishlistbody()
    );
  }
}