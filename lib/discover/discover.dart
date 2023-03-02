import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_head/Cart/cart.dart';
import 'package:sneaker_head/Profile/profile.dart';
import 'package:sneaker_head/Wishlist/wishlist.dart';
import 'package:sneaker_head/discover/categories_ui.dart';
import 'package:sneaker_head/discover/discoverheader.dart';
import 'package:sneaker_head/discover/showFeatured.dart';
import 'package:sneaker_head/models/model.dart';
import 'package:sneaker_head/no_splash.dart';
import 'package:sneaker_head/size_config.dart';

class Discover extends StatefulWidget {
  const Discover({
    Key? key,
  }) : super(key: key);

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  void initState() {
    super.initState();
    getDetails();
  }

  bool enabled = true;
  PersonalDetails? p;

  getDetails() async {
    PersonalDetails newP = PersonalDetails();
    await newP.getPersonalDetails();
    setState(() {
      p = newP;
    });
    print(p?.email ?? '');
  }

  signuserOut() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.signOut();
    setState(() {
      enabled = false;
    });
    Fluttertoast.showToast(msg: "Signed Out");
  }

  onSignedOut() {
    if (enabled == false) {
      setState(() {});
      return ShowFeatured();
    }
    else{
      return ShowFeatured();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("DISCOVER",
              style: GoogleFonts.ubuntu(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 2.5 * SizeConfig.textMultiplier)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        endDrawer: drawer(context),
        body: SizedBox(
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(
                top: 1.0 * SizeConfig.heightMultiplier,
                left: 1.6 * SizeConfig.widthMultiplier,
                right: 1.6 * SizeConfig.widthMultiplier),
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DiscoverHeader(),
                    SizedBox(
                      height: 1.5 * SizeConfig.heightMultiplier,
                    ),
                    Text(
                      "  Categories",
                      style: GoogleFonts.roboto(
                          fontSize: 3.0 * SizeConfig.textMultiplier,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 1.5 * SizeConfig.heightMultiplier,
                    ),
                    SingleChildScrollView(
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            CategoriesUI(
                              image: "assets/images/categories2.jpg",
                              text: "YEEZY's",
                              press: () {},
                            ),
                            CategoriesUI(
                                image: "assets/images/categories1.jpg",
                                text: "JORDAN's",
                                press: () {})
                          ],
                        )),
                    SizedBox(
                      height: 1.5 * SizeConfig.heightMultiplier,
                    ),
                    Text(
                      "  Featured",
                      style: GoogleFonts.roboto(
                          fontSize: 3.0 * SizeConfig.textMultiplier,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 2.0 * SizeConfig.heightMultiplier,
                    ),
                    onSignedOut()
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  drawer(BuildContext context) {
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      return Drawer(
        elevation: 10.0,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: CircleAvatar(
                      radius: 5.0 * SizeConfig.heightMultiplier,
                      backgroundImage: NetworkImage(p?.image ?? ""),
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 5.0 * SizeConfig.widthMultiplier,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 0.0 * SizeConfig.heightMultiplier),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Hey,",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 2.2 * SizeConfig.textMultiplier),
                        ),
                        Text(
                          p?.name ?? "",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 2.2 * SizeConfig.textMultiplier),
                        ),
                        SizedBox(height: 0.5 * SizeConfig.heightMultiplier),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 3.0 * SizeConfig.widthMultiplier),
              child: const Divider(
                color: Colors.black,
                thickness: 3,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                size: 3.0 * SizeConfig.heightMultiplier,
                color: Colors.black,
              ),
              title: Text(
                "Profile",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 2.2 * SizeConfig.textMultiplier),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Profile()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.favorite,
                size: 3.0 * SizeConfig.heightMultiplier,
                color: Colors.red,
              ),
              title: Text(
                "Wishlist",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 2.2 * SizeConfig.textMultiplier),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Wishlist()));
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart,
                  size: 3.0 * SizeConfig.heightMultiplier, color: Colors.black),
              title: Text(
                "Cart",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 2.2 * SizeConfig.textMultiplier),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Cart()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout,
                  size: 3.0 * SizeConfig.heightMultiplier, color: Colors.red),
              title: Text(
                "Sign Out",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 2.2 * SizeConfig.textMultiplier),
              ),
              onTap: () {
                signuserOut();
              },
            ),
          ],
        ),
      );
    }
  }
}
