import 'package:bloodchain/Constants/constantcolors.dart';
import 'package:bloodchain/Constants/constantvalues.dart';
import 'package:bloodchain/Pages/Home/homepage.dart';
import 'package:bloodchain/Pages/InitialSetup/uidinputpage.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BloodChain',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PreSplashScreen(),
    );
  }
}

class PreSplashScreen extends StatefulWidget {
  PreSplashScreen({Key? key}) : super(key: key);

  @override
  State<PreSplashScreen> createState() => _PreSplashScreenState();
}

class _PreSplashScreenState extends State<PreSplashScreen> {
  @override
  Widget build(BuildContext context) {
    CC cc = new CC();
    return EasySplashScreen(
        logo: Image.asset(
          "assets/med2.png",
        ),
        title: Text(
          "Medify",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: cc.mainbg,
        showLoader: true,
        navigator: UID == "null" ? EnterUID() : HomePage(),
        durationInSeconds: 3,
        loadingText: Text(
          "Scan to Save",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ));
  }
}
