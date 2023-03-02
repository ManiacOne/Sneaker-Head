import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sneaker_head/Login/login.dart';
import 'package:sneaker_head/Signup/sign_up.dart';
import 'package:sneaker_head/classify/classify_button.dart';
import 'package:sneaker_head/classify/classify_history.dart';
import 'package:sneaker_head/custom_text_button.dart';
import 'package:sneaker_head/size_config.dart';
import 'package:tflite/tflite.dart';
import 'package:google_fonts/google_fonts.dart' as GF;

class ClassifyBody extends StatefulWidget {
  const ClassifyBody({
    Key? key,
  }) : super(key: key);

  @override
  State<ClassifyBody> createState() => _ClassifyBodyState();
}

String imageUrl = '';

class _ClassifyBodyState extends State<ClassifyBody> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final _imagePicker = ImagePicker();
  bool _loading = true;
  List? outputs;
  File? _image;
  String shoeName = "";
  String shoeProb = "";

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  // @override
  // void dispose() {
  //   classifyImage(_image);
  //   super.dispose();
  // }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/models/model_unquant.tflite",
        labels: "assets/models/labels.txt");
    print("loaded");
  }

  classifyImage(File? image) async {
    var output = await Tflite.runModelOnImage(
        path: image!.path,
        numResults: 2,
        threshold: 0.3,
        imageMean: 0.0,
        imageStd: 255,
        asynch: true);
    setState(() {
      _loading = false;
      outputs = output;
    });
  }

  Future<dynamic> predictionBox() {
    return showDialog(
      context: this.context,
      builder: (ctx) => AlertDialog(
        actions: <Widget>[
          SizedBox(
            child: Padding(
              padding:
                  EdgeInsets.only(bottom: 3.0 * SizeConfig.heightMultiplier),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.file(
                    _image!,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 2.0 * SizeConfig.heightMultiplier,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Prediction: ",
                        maxLines: 2,
                        style: GF.GoogleFonts.ubuntu(
                            color: Colors.black,
                            fontSize: 2.5 * SizeConfig.textMultiplier,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${outputs?[0]["label"]}".substring(1),
                        maxLines: 2,
                        style: GF.GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 2.5 * SizeConfig.textMultiplier,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  CustomTextButton(
                      titlebuttontext: "Add to History",
                      press: () async {
                        await onPressHistory();
                      },
                      color: Colors.blue)
                ],
              ),
            ),
          )
        ],
      ),
      // barrierDismissible: false,
    );
  }

  navigatetogallery() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 25);
    if (image == null) {
      return;
    } else {
      setState(() {
        _loading = true;
        _image = File(image.path);
      });
      await classifyImage(_image);
      predictionBox();
    }
  }

  navigatetocamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    } else {
      setState(() {
        _loading = true;
        _image = File(image.path);
      });

      await classifyImage(_image);
      predictionBox();
      setState(() {});
    }
  }

  uploadImage() async {
    if (_image == null) {
      return;
    } else {
      final User? user = auth.currentUser;
      final userID = user?.uid;
      final fileName = basename(_image!.path);
      final destination = 'files/$fileName';
      print(fileName);
      try {
        final ref = FirebaseStorage.instance.ref(destination).child('file/');
        UploadTask uploadTask = ref.putFile(_image!);
        uploadTask.whenComplete(() async {
          imageUrl = await ref.getDownloadURL();
          print(imageUrl);
          await FirebaseFirestore.instance
              .collection("classification history")
              .add({
            'user_id': userID,
            'image': imageUrl,
            'time': Timestamp.now(),
            'title': outputs?[0]["label"]
          });
        });
      } catch (e) {
        print("error occured");
      }
    }
  }

  onPressHistory() async {
    if (FirebaseAuth.instance.currentUser == null) {
      alertforLogin();
    } else {
      await uploadImage();

      Navigator.pop(this.context);
    }
  }

  Future<dynamic> alertforLogin() {
    return showDialog(
        context: this.context,
        builder: (ctx) => AlertDialog(
              actions: <Widget>[
                SizedBox(
                  //height: 20.0*SizeConfig.heightMultiplier,
                  width: 80.0 * SizeConfig.widthMultiplier,
                  child: Padding(
                    padding: EdgeInsets.all(2.5 * SizeConfig.heightMultiplier),
                    child: Column(
                      children: [
                        Text(
                          "To wishlist this item you have to first log in to your account",
                          style: GF.GoogleFonts.ubuntu(
                              fontSize: 2.3 * SizeConfig.textMultiplier,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(height: 3.0 * SizeConfig.heightMultiplier),
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(this.context).push(
                                      MaterialPageRoute(
                                          builder: (context) => SignUp()));
                                },
                                child: Text("SIGNUP",
                                    style: GF.GoogleFonts.ubuntu(
                                        fontSize:
                                            2.2 * SizeConfig.textMultiplier,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.green))),
                            const Spacer(),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(this.context).push(
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                                child: Text("LOGIN",
                                    style: GF.GoogleFonts.ubuntu(
                                        fontSize:
                                            2.2 * SizeConfig.textMultiplier,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.blue)))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0 * SizeConfig.heightMultiplier),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Prediction",
            style: GF.GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 4.0 * SizeConfig.textMultiplier,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 2.0 * SizeConfig.heightMultiplier),
          Text(
            "Now you can predict any OG shoes",
            style: GF.GoogleFonts.roboto(
                color: const Color.fromARGB(255, 51, 64, 70),
                fontSize: 2.4 * SizeConfig.textMultiplier,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "you look at",
            style: GF.GoogleFonts.roboto(
                color: const Color.fromARGB(255, 51, 64, 70),
                fontSize: 2.4 * SizeConfig.textMultiplier,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6.0 * SizeConfig.heightMultiplier),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClassifyButton(
                press: () {
                  navigatetogallery();
                },
                icon: Icons.image,
                color: Colors.blue,
                buttonName: "Gallery",
              ),
              SizedBox(
                width: 6.0 * SizeConfig.heightMultiplier,
              ),
              ClassifyButton(
                press: () => navigatetocamera(),
                icon: Icons.camera_alt,
                color: Colors.orange,
                buttonName: "Camera",
              ),
              SizedBox(
                width: 6.0 * SizeConfig.heightMultiplier,
              ),
              ClassifyButton(
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ClassifyHistory()));
                },
                icon: Icons.history,
                color: Colors.orange,
                buttonName: "History",
              )
            ],
          ),
        ],
      ),
    );
  }
}
