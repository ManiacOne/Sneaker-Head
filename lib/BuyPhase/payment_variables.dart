import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/size_config.dart';

class PaymentVariables extends StatefulWidget {
  const PaymentVariables({
    Key? key, required this.headline1, required this.headline2, required this.image, required this.scale,
  }) : super(key: key);
  final String headline1;
  final String headline2;
  final String image;
  final double scale;
  
  @override
  State<PaymentVariables> createState() => _PaymentVariablesState();
}

class _PaymentVariablesState extends State<PaymentVariables> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            height: 9.0 * SizeConfig.heightMultiplier,
            width: 9.2 * SizeConfig.heightMultiplier,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white),
            child: Image.asset(
              widget.image,scale: widget.scale,
            )),
        Expanded(
          child: SizedBox(
            height: 10.0 * SizeConfig.heightMultiplier,
            //width: 100.0 * SizeConfig.widthMultiplier,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 1.0 * SizeConfig.heightMultiplier,
                  vertical: 2.0 * SizeConfig.heightMultiplier),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.headline1,
                    style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.w600,
                        fontSize: 2.5 * SizeConfig.textMultiplier),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Text(
                    widget.headline2,
                    style: GoogleFonts.ubuntu(
                        color: Color.fromARGB(255, 79, 79, 79),
                        fontWeight: FontWeight.w600,
                        fontSize: 2.2 * SizeConfig.textMultiplier),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
        IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 3.0 * SizeConfig.heightMultiplier,
                color: Color.fromARGB(255, 108, 108, 108),
              ),
            ),
        // Container(
        //     margin: EdgeInsets.symmetric(
        //         horizontal: 2.0 * SizeConfig.widthMultiplier),
        //     height: 4.0 * SizeConfig.heightMultiplier,
        //     width: 5.0 * SizeConfig.heightMultiplier,
        //     decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         border: Border.all(color: Colors.grey),
        //         color: Colors.orange),
        //     child: Container(
        //       margin: EdgeInsets.symmetric(
        //           horizontal: 3.0 * SizeConfig.widthMultiplier),
        //       decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: Colors.white),
        //     ))
      ],
    );
  }
}
