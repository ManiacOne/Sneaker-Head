import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sneaker_head/no_splash.dart';
import 'package:sneaker_head/size_config.dart';

import '../Cart/cart_body.dart';

class ClassifyHistory extends StatelessWidget {
  const ClassifyHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text("History",
            style: GoogleFonts.ubuntu(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 2.5 * SizeConfig.textMultiplier)),
      ),
      body: ScrollConfiguration(
          behavior: NoSplashBehaviour(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 2.0 * SizeConfig.widthMultiplier,
                vertical: 2.0 * SizeConfig.heightMultiplier),
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("classification history")
                    .where("user_id", isEqualTo: userID)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          DateTime currentTime= DateTime.now();
                          Timestamp senttime = snapshot.data?.docs[i]['time'];
                          DateTime sendertime = senttime.toDate();
                          String todaytime = DateFormat.jm().format(sendertime);
                          String fulltime = DateFormat('kk:mm  yyyy-MM-dd').format(sendertime);
                          return Card(
                            margin: i == 0
                                ? EdgeInsets.symmetric(
                                    vertical: 0.0 * SizeConfig.heightMultiplier)
                                : EdgeInsets.symmetric(
                                    vertical:
                                        1.3 * SizeConfig.heightMultiplier),
                            child: Container(
                              height: 42.0 * SizeConfig.heightMultiplier,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(2)),
                              child: Column(
                                children: [
                                  SizedBox(
                                      height:
                                          30.0 * SizeConfig.heightMultiplier,
                                      child: Image.network(
                                        snapshot.data!.docs[i]["image"],
                                        fit: BoxFit.contain,
                                      )),
                                  SizedBox(
                                    height: 1.5 * SizeConfig.heightMultiplier,
                                  ),
                                  Text("${snapshot.data!.docs[i]["title"]}".substring(1),
                                      style: GoogleFonts.ubuntu(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize:
                                              3.0 * SizeConfig.textMultiplier)),
                                  SizedBox(
                                    height: 1.5 * SizeConfig.heightMultiplier,
                                  ),
                                  Text((currentTime.year == sendertime.year)
                                          && (currentTime.month == sendertime.month)
                                          && (currentTime.day == sendertime.day)?
                                          todaytime:
                                          fulltime,
                                      style: GoogleFonts.ubuntu(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              2.0 * SizeConfig.textMultiplier)),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                  if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    return emptydocs();
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return connectionwaiting();
                  } else {
                    return nodata();
                  }
                }),
          )),
    );
  }
}
