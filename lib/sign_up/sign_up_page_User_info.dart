import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flora1/Utilities/Utilities.dart';
import 'package:flora1/db/db_functions/db_functions.dart';
import 'package:flora1/login_page.dart';
import 'package:flora1/sign_up/sign_in_page.dart';
import 'package:flora1/splash_screen.dart';
import 'package:flutter/material.dart';

class Sign_Up_User_info extends StatefulWidget {
  const Sign_Up_User_info({super.key});

  @override
  State<Sign_Up_User_info> createState() => _Sign_Up_User_infoState();
}

class _Sign_Up_User_infoState extends State<Sign_Up_User_info> {
  var collection = FirebaseFirestore.instance.collection("users");
  var user_cred = FirebaseFirestore.instance.collection("User_credentials");
  var user_info = FirebaseFirestore.instance.collection("users_info");

  final TextEditingController first_name = TextEditingController();
  final TextEditingController Sec_name = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController zone = TextEditingController();

  void add_user_info(int c) {
    final user_info = {
      'Name': first_name.text + Sec_name.text,
      'mobile': mobile.text,
      'zone': zone.text,
      'current_stage': 0,
      'last_collected_date': "0000-00-00",
      'plastic_collected': 0,
      'User_id': (zone.text) + (c.toString())
    };

    collection.doc(zone.text + c.toString()).set(user_info).then((value) {
      create_user(first_name.text, Sec_name.text, zone.text, mobile.text,
              "${zone.text + (c.toString())}")
          .then((value) {
        user_cred
            .doc(User_name)
            .update({'user_id': "${zone.text + (c.toString())}"}).then((value) {
          isSigned = true;
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return const login_page();
          }));
        });
      });
    });
  }

  Future change_count() async {
    final count_ref = await user_info.doc('Users_count').get();

    user_info
        .doc('Users_count')
        .update({'count': (count_ref["count"] + 1)}).then((value) {
      add_user_info(count_ref["count"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("User informations")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: first_name,
                  decoration: InputDecoration(
                    hintText: "First name",
                    border: OutlineInputBorder(),
                  ),
                ),
                const spacer10(),
                TextField(
                  controller: Sec_name,
                  decoration: InputDecoration(
                      hintText: "Second name", border: OutlineInputBorder()),
                ),
                const spacer10(),
                TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  controller: mobile,
                  decoration: InputDecoration(
                      hintText: "Mobile No", border: OutlineInputBorder()),
                ),
                const spacer10(),
                TextField(
                  controller: zone,
                  decoration: InputDecoration(
                      hintText: "Zone", border: OutlineInputBorder()),
                ),
                const spacer10(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (first_name.text != '' &&
                            Sec_name.text != '' &&
                            zone.text != '' &&
                            (mobile.text != '' && mobile.text.length == 10) &&
                            "${zone.text}" != '') {
                          change_count();
                        } else {
                          const warning = SnackBar(
                            content: Text("Enter valid information!"),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            elevation: 10,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(warning);
                        }
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),

                    // ElevatedButton(
                    //   onPressed: () async {
                    //     List<Map> list =
                    //         await db.rawQuery('SELECT * FROM User_Info');
                    //     list.forEach((element) {
                    //       print(element);
                    //     });

                    //     // print(list);
                    //   },
                    //   child: const Text(
                    //     "View",
                    //     style: TextStyle(fontSize: 20),
                    //   ),
                    // ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Delete(first_name.text);
                    //   },
                    //   child: const Text(
                    //     "Delete",
                    //     style: TextStyle(fontSize: 20),
                    //   ),
                    // )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
