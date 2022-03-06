import 'package:bloodchain/Constants/constantcolors.dart';
import 'package:bloodchain/Constants/constantvalues.dart';
import 'package:bloodchain/Pages/Home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRHomePage extends StatefulWidget {
  QRHomePage({Key? key}) : super(key: key);

  @override
  State<QRHomePage> createState() => _QRHomePageState();
}

class _QRHomePageState extends State<QRHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: QrImage(
              data: UID,
              version: QrVersions.auto,
              size: 300.0,
            ),
          ),
        ],
      ),
    );
  }
}
