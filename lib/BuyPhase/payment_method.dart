import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/BuyPhase/payment_variables.dart';
import 'package:sneaker_head/size_config.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Payment Method",
            style: GoogleFonts.ubuntu(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 2.5 * SizeConfig.textMultiplier)),
        SizedBox(
          height: 3.0 * SizeConfig.heightMultiplier,
        ),
        Column(
          children: [
            PaymentVariables(
              headline1: "Master Card",
              headline2: "**** **** 4058 5596",
              image: "assets/images/mastercard.png",
              scale: 4.0,
            ),
            SizedBox(height: 2.0*SizeConfig.heightMultiplier,),
            PaymentVariables(
                headline1: "Apple Pay",
                headline2: "**** **** 4058 5596",
                image: "assets/images/apple2.png",
              scale: 15.0,
                ),
            SizedBox(height: 2.0*SizeConfig.heightMultiplier,),
            PaymentVariables(
                headline1: "Master Card",
                headline2: "**** **** 4058 5596",
                image: "assets/images/mastercard.png",
              scale: 1.0,
                )
          ],
        )
      ],
    );
  }
}
