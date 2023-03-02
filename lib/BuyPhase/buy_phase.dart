import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/BuyPhase/buy_phase_body.dart';
import 'package:sneaker_head/size_config.dart';

class BuyPhase extends StatefulWidget {
  const BuyPhase(
      {Key? key,
      required this.productImage,
      required this.productSize,
      required this.productTitle,
      required this.productPrice})
      : super(key: key);
  final String productImage;
  final int productSize;
  final String productTitle;
  final int productPrice;

  @override
  State<BuyPhase> createState() => _BuyPhaseState();
}

class _BuyPhaseState extends State<BuyPhase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text("Checkout",
            style: GoogleFonts.ubuntu(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 2.5 * SizeConfig.textMultiplier)),
      ),
      body: BuyPhaseBody(
        productTitle: widget.productTitle,
        productImage: widget.productImage,
        productSize: widget.productSize,
        productPrice: widget.productPrice,
      ),
    );
  }
}
