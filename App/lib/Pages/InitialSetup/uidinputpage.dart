import 'package:bloodchain/Constants/constantcolors.dart';
import 'package:bloodchain/Constants/constantvalues.dart';
import 'package:bloodchain/Pages/Home/homepage.dart';
import 'package:flutter/material.dart';

class EnterUID extends StatefulWidget {
  EnterUID({Key? key}) : super(key: key);

  @override
  State<EnterUID> createState() => _EnterUIDState();
}

class _EnterUIDState extends State<EnterUID> {
  final uidC = TextEditingController();
  CC cc = new CC();
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
          "Enter UID",
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Use"),
        onPressed: () {
          UID = uidC.text;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
      ),
      body: Column(
        children: [
          SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: TextFormField(
              controller: uidC,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  labelText: "Enter UID",
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
          ),
          SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
