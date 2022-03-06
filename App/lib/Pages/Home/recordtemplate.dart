import 'package:bloodchain/Constants/constantcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class RecordTemplate extends StatefulWidget {
  String name;
  String bg;
  String db;
  String vc;
  String std;
  RecordTemplate(
      {required this.name,
      required this.bg,
      required this.db,
      required this.std,
      required this.vc});

  @override
  State<RecordTemplate> createState() => _RecordTemplateState();
}

const htmlData = r"""
      <h1><name></name>'s Medical Record</h1>
       <table>  
            <tr>  
                <th>Fields</th>  
                <th>Details</th>    
            </tr>  
            <tr>  
                <td>Name</td> 
                <td><name></name></td>  
            </tr> 
            <tr>
                <td>Blood Group</td>
                <td><bgrp></bgrp></td>
                </tr>
            <tr>
                <td>Vaccine History</td>
                <td><vc></vc></td>  
            </tr>
            <tr>
                <td>STDs</td>
                <td><std></std></td>
            </tr>
            <tr>  
                <td> Diabetes</td>
                <td><db></db></td>
            </tr>  
                
          
 
        </table>  
      
      
""";

class _RecordTemplateState extends State<RecordTemplate> {
  CC cc = new CC();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cc.mainbg,
        title: Text('Medical Record'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Html(
            data: htmlData,
            tagsList: Html.tags..addAll(["name", "std", "db", "bgrp", "vc"]),
            style: {
              "table": Style(
                backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
              ),
              "tr": Style(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              "th": Style(
                padding: EdgeInsets.all(6),
                backgroundColor: Colors.grey,
              ),
              "td": Style(
                fontSize: FontSize(26),
                padding: EdgeInsets.all(6),
                alignment: Alignment.topLeft,
              ),
              'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
            },
            customRender: {
              "name": (RenderContext context, Widget child) {
                return TextSpan(
                    text: widget.name, style: TextStyle(color: Colors.black));
              },
              "bgrp": (RenderContext context, Widget child) {
                return TextSpan(
                    text: widget.bg, style: TextStyle(color: Colors.black));
              },
              "vc": (RenderContext context, Widget child) {
                return TextSpan(
                    text: widget.vc, style: TextStyle(color: Colors.black));
              },
              "std": (RenderContext context, Widget child) {
                return TextSpan(
                    text: widget.std, style: TextStyle(color: Colors.black));
              },
              "db": (RenderContext context, Widget child) {
                return TextSpan(
                    text: widget.db, style: TextStyle(color: Colors.black));
              },
            }),
      ),
    );
  }
}
