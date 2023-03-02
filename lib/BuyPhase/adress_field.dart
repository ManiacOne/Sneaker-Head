import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/size_config.dart';

class AdressField extends StatelessWidget {
  const AdressField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Delivery Address",
            style: GoogleFonts.ubuntu(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 2.5 * SizeConfig.textMultiplier)),
        SizedBox(
          height: 3.0 * SizeConfig.heightMultiplier,
        ),
        Row(
          children: [
            Container(
              height: 9.0 * SizeConfig.heightMultiplier,
              width: 9.2 * SizeConfig.heightMultiplier,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.white),
              child: Icon(
                Icons.location_on_rounded,
                size: 6.0 * SizeConfig.heightMultiplier,
              ),
            ),
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
                        "20845 Oakridge Farm Lane",
                        style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w600,
                            fontSize: 2.3 * SizeConfig.textMultiplier),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Text(
                        "New York NYC",
                        style: GoogleFonts.ubuntu(
                            color: Color.fromARGB(255, 79, 79, 79),
                            fontWeight: FontWeight.w600,
                            fontSize: 2.2 * SizeConfig.textMultiplier),
                        overflow: TextOverflow.ellipsis,
                      )
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
          ],
        ),
      ],
    );
  }
}
