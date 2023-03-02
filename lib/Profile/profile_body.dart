import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import 'package:sneaker_head/Profile/change_profile.dart';
import 'package:sneaker_head/Profile/user_details.dart';
import 'package:sneaker_head/models/model.dart';
import 'package:sneaker_head/size_config.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  PersonalDetails? p;

  getDetails() async {
    PersonalDetails newP = PersonalDetails();
    await newP.getPersonalDetails();
    setState(() {
      p = newP;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NoGlowScroll(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 3.0 * SizeConfig.widthMultiplier,
              vertical: 2.0 * SizeConfig.heightMultiplier),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChangeProfile(p: p),
              SizedBox(height: 8.0 * SizeConfig.heightMultiplier),
              UserDetails(first: "Name - ", second: "${p?.name}",),
              SizedBox(height: 3.0 * SizeConfig.heightMultiplier),
              UserDetails(first: "Email - ", second: "${p?.email}",)

            ],
          ),
        ),
      ),
    );
  }
}

