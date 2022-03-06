import 'package:bloodchain/Constants/constantcolors.dart';
import 'package:bloodchain/Constants/constantvalues.dart';
import 'package:bloodchain/Pages/Home/myoptions.dart';
import 'package:bloodchain/Pages/Home/qrhome.dart';
import 'package:bloodchain/Pages/Home/recordtemplate.dart';
import 'package:bloodchain/Pages/InitialSetup/uidmodel.dart';
import 'package:bloodchain/Pages/RecordSubmission/addrecord.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String RECORD = "";
  String R_name = "";
  String R_bg = "";
  String R_vac = "";
  String R_std = "";
  String R_dib = "";

  late Client httpClient;
  late Web3Client ethClient;
  final String myAddress = "0xF6Ac054b24aF751c6683f8169a4eCd6ede570324";
  final String blockchainUrl =
      "https://rinkeby.infura.io/v3/c489922ee78345e79caeb7f0e9210ff3";
  CC cc = new CC();
  // ASHTE
  Future<DeployedContract> getContract() async {
//obtain our smart contract using rootbundle to access our json file
    String abiFile = await rootBundle.loadString("assets/contract.json");
    String contractAddress = "0x09065e3c78964772847ebfb29bbbbd8cefa67c86";

    final contract = DeployedContract(ContractAbi.fromJson(abiFile, "Medifi"),
        EthereumAddress.fromHex(contractAddress));

    return contract;
  }

  Future<List<dynamic>> callFunction(String name, int uid) async {
    final contract = await getContract();
    final function = contract.function(name);
    final result = await ethClient.call(
        contract: contract, function: function, params: [BigInt.from(uid)]);
    return result;
  }

  Future<void> getMyRecord(int uid) async {
    List<dynamic> resultsA = await callFunction("getAll", uid);
    print(resultsA);
    setState(() {
      R_name = resultsA[0][2];
      R_bg = resultsA[0][3];
      R_vac = resultsA[0][4];
      R_std = resultsA[0][5];
      R_dib = resultsA[0][6];
    });
    print(R_name);
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchweb(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    getMyRecord(int.parse(barcodeScanRes));
    showAlertDialog(BuildContext context) {
      // set up the button
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {},
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("My title"),
        content: Text("This is my message."),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  String _scanBarcode = 'Unknown';

  final List<Widget> pages = [QRHomePage(), MyOptions()];
  var _bottomNavIndex = 0; //default index of a first screen

  final iconList = <IconData>[
    Icons.home,
    Icons.feed,
  ];
  String qrCodeResult = "0";
  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(blockchainUrl, httpClient);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(UID);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: cc.whiteColor,
        title: Text(
          "Home",
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: cc.mainbg,
        elevation: 8,
        child: Icon(
          Icons.camera_alt_rounded,
        ),
        onPressed: () async {
          scanQR();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => RecordTemplate(
                  name: R_name, bg: R_bg, db: R_dib, std: R_std, vc: R_vac)));

          // return showDialog(
          //   context: context,
          //   builder: (ctx) => AlertDialog(
          //     title: Text("Medical Record"),
          //     content: SizedBox(
          //       height: 250,
          //       child: Column(
          //         children: [
          //           Row(
          //             children: [
          //               Text(
          //                 "Name :  ",
          //                 style: TextStyle(fontSize: 22),
          //               ),
          //               Text(
          //                 R_name,
          //                 style: TextStyle(fontSize: 22),
          //               )
          //             ],
          //           ),
          //           Row(
          //             children: [
          //               Text(
          //                 "Blood group :  ",
          //                 style: TextStyle(fontSize: 22),
          //               ),
          //               Text(
          //                 R_bg,
          //                 style: TextStyle(fontSize: 22),
          //               )
          //             ],
          //           ),
          //           Row(
          //             children: [
          //               Text(
          //                 "Diabeties :  ",
          //                 style: TextStyle(fontSize: 22),
          //               ),
          //               Text(
          //                 R_dib,
          //                 style: TextStyle(fontSize: 22),
          //               )
          //             ],
          //           ),
          //           Row(
          //             children: [
          //               Text(
          //                 "Vaccination :",
          //                 style: TextStyle(fontSize: 22),
          //               ),
          //               Text(
          //                 R_vac,
          //                 style: TextStyle(fontSize: 22),
          //               )
          //             ],
          //           ),
          //           Row(
          //             children: [
          //               Text(
          //                 "STDs :",
          //                 style: TextStyle(fontSize: 22),
          //               ),
          //               Text(
          //                 R_std,
          //                 style: TextStyle(fontSize: 22),
          //               )
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //     actions: <Widget>[
          //       FlatButton(
          //         onPressed: () {
          //           Navigator.of(ctx).pop();
          //         },
          //         child: Text("Download"),
          //       ),
          //     ],
          //   ),
          // );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        activeColor: Colors.white,
        backgroundColor: cc.mainbg,
        elevation: 12,
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.defaultEdge,

        onTap: (index) => setState(() => _bottomNavIndex = index),
        //other params
      ),
      body: pages[_bottomNavIndex],
    );
  }
}
