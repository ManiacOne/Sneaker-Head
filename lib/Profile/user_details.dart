import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/size_config.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({
    Key? key,
    required this.first,
    required this.second,
  }) : super(key: key);

  final String first;
  final String second;

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: 3.0 * SizeConfig.widthMultiplier),
      height: 6.5 * SizeConfig.heightMultiplier,
      width: 100.0 * SizeConfig.widthMultiplier,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black),
          color: const Color.fromARGB(255, 196, 195, 195)),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 7.0 * SizeConfig.widthMultiplier),
        child: Row(
          children: [
            Text(
              widget.first,
              style: GoogleFonts.hindSiliguri(
                  fontSize: 2.3 * SizeConfig.textMultiplier,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              widget.second,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: GoogleFonts.hindSiliguri(
                  fontSize: 2.2 * SizeConfig.textMultiplier,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
