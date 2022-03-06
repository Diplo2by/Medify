import 'package:bloodchain/Constants/constantcolors.dart';
import 'package:bloodchain/Pages/Home/homepage.dart';
import 'package:bloodchain/Pages/RecordSubmission/addrecord.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class BlockchainPAge extends StatefulWidget {
  BlockchainPAge({Key? key}) : super(key: key);

  @override
  State<BlockchainPAge> createState() => _BlockchainStatePAge();
}

class _BlockchainStatePAge extends State<BlockchainPAge> {
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
    String contractAddress = "0xea5093Cc6D342a937b0B584B5326F200Fb4b6C3a";

    final contract = DeployedContract(ContractAbi.fromJson(abiFile, "Medifi"),
        EthereumAddress.fromHex(contractAddress));

    return contract;
  }

  Future<List<dynamic>> callFunction(String name) async {
    final contract = await getContract();
    final function = contract.function(name);
    final result = await ethClient
        .call(contract: contract, function: function, params: [BigInt.from(2)]);
    return result;
  }

  Future<void> getTotalVotes() async {
    List<dynamic> resultsA = await callFunction("get");
    print(resultsA);

    setState(() {});
  }

  Future<void> vote() async {
    Credentials key = EthPrivateKey.fromHex(
        "5656ef8a54cb2808f83b72c8079ca6be693c4b4617d51a79445773bdb06a9f57");

    final contract = await getContract();

    final function = contract.function("UploadRecord");

    await ethClient.sendTransaction(
        key,
        Transaction.callContract(
            contract: contract,
            function: function,
            parameters: ["Eminem", "MGK", "asd", "23", "Sdas", "roxam", "End"]),
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
          "Blockchain go brrrr",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(78, 16, 78, 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  primary: cc.mainbg,
                  elevation: 0.0,
                  fixedSize: const Size(340, 60),
                  textStyle: TextStyle(fontSize: 16, color: cc.mainbg)),
              onPressed: () {
                vote();
              },
              child: Text(
                "Log Out",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
