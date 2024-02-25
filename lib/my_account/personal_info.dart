import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flora1/colors.dart';
import 'package:flora1/db/db_functions/db_functions.dart';
import 'package:flutter/material.dart';

class personal_info extends StatefulWidget {
  const personal_info({super.key});

  @override
  State<personal_info> createState() => _personal_infoState();
}

class _personal_infoState extends State<personal_info> {
  var collection = FirebaseFirestore.instance.collection("users");
  List count = [0];
  late List items = [];
  var user;
  bool isloaded = false;

  _call() async {
    List templist = [];
    List<Map> table = (await db.rawQuery('SELECT * FROM User_Info'));
    var data =
        await collection.doc(table.elementAt(0).values.elementAt(4)).get();
    user = table.elementAt(0).values.elementAt(4);
    templist.add(data["Name"]);
    templist.add(data["mobile"]);
    templist.add(data["zone"]);
    templist.add(data['User_id']);
    setState(() {
      items = templist;
      isloaded = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _call();
  }

  @override
  Widget build(BuildContext context) {
    return isloaded
        ? Scaffold(
            appBar: AppBar(title: const Text("Personal Informations")),
            body: ListView(
              children: [
                user_info_tile("${items[0]}".toUpperCase(), 'Your Name'),
                user_info_tile("${items[1]}", 'Mobile No.'),
                user_info_tile("${items[2]}".toUpperCase(), 'Zone'),
                user_info_tile('${items[3]}', 'User Id')
              ],
            ),
          )
        : Container();
  }

  Padding user_info_tile(String val, String head) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: double.infinity,
        height: 130,
        color: pri_color1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "${head}",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${val}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[600]),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
