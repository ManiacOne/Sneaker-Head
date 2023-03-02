import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/BuyPhase/adress_field.dart';
import 'package:sneaker_head/BuyPhase/payment_method.dart';
import 'package:sneaker_head/no_splash.dart';
import 'package:sneaker_head/size_config.dart';

class BuyPhaseBody extends StatefulWidget {
  const BuyPhaseBody(
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
  State<BuyPhaseBody> createState() => _BuyPhaseBodyState();
}

class _BuyPhaseBodyState extends State<BuyPhaseBody> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 2.0 * SizeConfig.heightMultiplier,
              vertical: 2.0 * SizeConfig.heightMultiplier),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdressField(),
              SizedBox(
                height: 4.0 * SizeConfig.heightMultiplier,
              ),
              PaymentMethod(),
              SizedBox(
                height: 4.0 * SizeConfig.heightMultiplier,
              ),
              Text("Item Preview",
                  style: GoogleFonts.ubuntu(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 2.5 * SizeConfig.textMultiplier)),
              SizedBox(
                height: 3.0 * SizeConfig.heightMultiplier,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15.0 * SizeConfig.heightMultiplier,
                    width: 40.0 * SizeConfig.widthMultiplier,
                    child: Image.network(
                      widget.productImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 2.0 * SizeConfig.widthMultiplier,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.productTitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.ubuntu(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 2.2 * SizeConfig.textMultiplier)),
                        SizedBox(
                          width: 1.0 * SizeConfig.widthMultiplier,
                        ),
                        Text("Price - Rs ${widget.productPrice}",
                            style: GoogleFonts.ubuntu(
                                color: Color.fromARGB(255, 79, 79, 79),
                                fontWeight: FontWeight.w500,
                                fontSize: 2.3 * SizeConfig.textMultiplier)),
                        SizedBox(
                          width: 1.0 * SizeConfig.widthMultiplier,
                        ),
                        Text("Size - ${widget.productSize} UK",
                            style: GoogleFonts.ubuntu(
                                color: Color.fromARGB(255, 79, 79, 79),
                                fontWeight: FontWeight.w500,
                                fontSize: 2.3 * SizeConfig.textMultiplier)),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
