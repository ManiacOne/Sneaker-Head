import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sneaker_head/choose/choose.dart';
import 'package:sneaker_head/dismiss_keyboard.dart';
import 'package:sneaker_head/size_config.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints) {
        return OrientationBuilder(
          builder: (context,orientation) {
            SizeConfig().init(constraints,orientation);
            return DismissKeyboard(
              child: MaterialApp(
                title: 'Sneaker Head',
                theme: ThemeData(
                  primarySwatch: Colors.blue,errorColor: Colors.orange
                ),
                home:const Choose(),
                debugShowCheckedModeBanner: false,
              ),
            );
          }
        );
      }
    );
  }
}
