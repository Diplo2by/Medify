import 'package:bloodchain/Constants/constantcolors.dart';
import 'package:bloodchain/Pages/Home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:bloodchain/Constants/constantcolors.dart';
import 'package:bloodchain/Pages/Home/homepage.dart';
import 'package:bloodchain/Pages/RecordSubmission/addrecord.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class AddRecord extends StatefulWidget {
  AddRecord({Key? key}) : super(key: key);

  @override
  State<AddRecord> createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  final nameC = TextEditingController();
  final bgC = TextEditingController();
  final heightC = TextEditingController();
  final allergiesC = TextEditingController();
  final stdC = TextEditingController();
  final vacC = TextEditingController();
  final miscC = TextEditingController();

  String RECORD = "";

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

    setState(() {});
  }

  Future<void> UploadMyRecord() async {
    Credentials key = EthPrivateKey.fromHex(
        "5656ef8a54cb2808f83b72c8079ca6be693c4b4617d51a79445773bdb06a9f57");

    final contract = await getContract();
    final function = contract.function("UploadRecord");
    await ethClient.sendTransaction(
        key,
        Transaction.callContract(
            contract: contract,
            function: function,
            parameters: [
              "12321",
              "${nameC.text}321",
              "${nameC.text}",
              "${bgC.text}",
              "${vacC.text}",
              "${stdC.text}",
              "Yes"
            ]),
        chainId: 4);
    Future.delayed(const Duration(seconds: 20), () {
      print("Successfully inserted");
    });
  }

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(blockchainUrl, httpClient);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.white, // <= You can change your color here.
        ),
        elevation: 0,
        backgroundColor: cc.mainbg,
        title: Text(
          "Medical Record",
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          setState(() {
            RECORD =
                "${nameC.text}\n${bgC.text}\n${heightC.text}\n${allergiesC.text}\n${stdC.text}\n${vacC.text}\n${miscC.text}\n";
          });
          print(RECORD);
          UploadMyRecord();
          // getMyRecord(1);
        },
        label: Text('Submit'),
        icon: Icon(Icons.add),
        backgroundColor: cc.mainbg,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameC,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: cc.mainbg, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: cc.mainbg, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    )),
                // validator: (val) =>
                //     5 < 6 ? "Password should be 6 characters" : null,
              ),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                controller: bgC,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: "Blood Group",
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: cc.mainbg, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: cc.mainbg, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    )),
                // validator: (val) =>
                //     5 < 6 ? "Password should be 6 characters" : null,
              ),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                controller: heightC,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: "Height",
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: cc.mainbg, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: cc.mainbg, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    )),
                // validator: (val) =>
                //     5 < 6 ? "Password should be 6 characters" : null,
              ),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                controller: allergiesC,
                maxLines: 2,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: "Allergies",
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: cc.mainbg, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: cc.mainbg, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    )),
                // validator: (val) =>
                //     5 < 6 ? "Password should be 6 characters" : null,
              ),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                controller: stdC,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: "STDs",
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: cc.mainbg, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: cc.mainbg, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    )),
                // validator: (val) =>
                //     5 < 6 ? "Password should be 6 characters" : null,
              ),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                controller: vacC,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: "Vaccination History",
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: cc.mainbg, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: cc.mainbg, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    )),
                // validator: (val) =>
                //     5 < 6 ? "Password should be 6 characters" : null,
              ),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                controller: miscC,
                maxLines: 3,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: "Other Medical Details",
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: cc.mainbg, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: cc.mainbg, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    )),
                // validator: (val) =>
                //     5 < 6 ? "Password should be 6 characters" : null,
              ),
              SizedBox(
                height: 64,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
