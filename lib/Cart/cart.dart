import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/Cart/cart_body.dart';
import 'package:sneaker_head/size_config.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          "My Cart",
          style: GoogleFonts.ubuntu(
            fontSize: 2.5*SizeConfig.textMultiplier,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
      ),
      body: CartBody()
    );
  }
}
