import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flora1/Utilities/Utilities.dart';

import 'package:flora1/home.dart';
import 'package:flora1/qr_Scanner.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Scanner_info extends StatefulWidget {
  const Scanner_info({super.key});

  State<Scanner_info> createState() => _Scanner_infoState();
}

class _Scanner_infoState extends State<Scanner_info> {
  final _globalKey = GlobalKey<ScaffoldMessengerState>();
  var user_id1;
  var collection = FirebaseFirestore.instance.collection("users");
  List count = [0];
  late List items = [];
  var user;
  bool isloaded = false;
  final TextEditingController weight = TextEditingController();
  String? Date;
  _call() async {
    List templist = [];
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    var data = await collection.doc(scan_result).get();

    templist.add(data["Name"]);
    templist.add(data["User_id"]);
    templist.add(formattedDate);
    templist.add(data["current_stage"]);
    templist.add(data["plastic_collected"]);
    setState(() {
      items = templist;
      isloaded = true;
      Date = formattedDate;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _call();
  }

  void add_collecton() {
    final collection_data = {
      'collection_date': Date,
      'Weight': weight.text,
    };
    if (weight.text.isNotEmpty) {
      FirebaseFirestore.instance
          .collection("users")
          .doc("${items[1].toString()}")
          .update({
        'current_stage': (items[3] + 1),
        'last_collected_date': Date,
        'plastic_collected': (items[4] + (double.parse(weight.text)))
      }).then((value) {
        weight.clear();
        FirebaseFirestore.instance
            .collection("users/${items[1].toString()}/collection_info")
            .doc((items[3] + 1).toString())
            .set(collection_data)
            .then((value) {
          weight.clear();
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return const Home();
          }));
        });
      });
    } else {
      var snackBar =
          SnackBar(content: Text('Enter the amount of plastic collected'));
      _globalKey.currentState?.showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Informations"),
      ),
      body: isloaded
          ? ListView(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        display_user_info("NAME: ", "${items[0].toString()}"),
                        spacer10(),
                        display_user_info(
                            "USER ID: ", "${items[1].toString()}"),
                        spacer10(),
                        display_user_info("DATE: ", "${items[2].toString()}"),
                        spacer10(),
                        Text(
                          "Enter the Weight of Plastic Collected",
                          style: TextStyle(fontSize: 15),
                        ),
                        spacer10(),
                        TextField(
                          controller: weight,
                          decoration: InputDecoration(
                              hintText: "Enter the Weight",
                              border: OutlineInputBorder()),
                        ),
                        spacer10(),
                        ElevatedButton(
                            onPressed: () {
                              add_collecton();
                            },
                            child: Text("Mark as Collected",
                                style: TextStyle(fontSize: 15)))
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Container(),
    );
  }

  Container display_user_info(String Main_txt, String Sub_txt) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      height: 50,
      width: double.infinity,
      child: Row(
        children: [
          Text(
            "${Main_txt}",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "${Sub_txt}",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
