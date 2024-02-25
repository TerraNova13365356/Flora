import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flora1/Utilities/Utilities.dart';
import 'package:flora1/ac.dart';
import 'package:flutter/material.dart';

class Edit_acc extends StatefulWidget {
  Edit_acc({super.key});

  @override
  State<Edit_acc> createState() => _Edit_accState();
}

class _Edit_accState extends State<Edit_acc> {
  final TextEditingController name = TextEditingController();

  final TextEditingController mobile = TextEditingController();

  final TextEditingController zone = TextEditingController();

  var collection = FirebaseFirestore.instance.collection("users");

  List count = [0];

  // List items = [];

  bool isloaded = false;

  _call() async {
    setState(() {
      isloaded = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _call();
    name.text = items[0];
    mobile.text = items[1];
    zone.text = items[2];
  }

  void Edit() {
    FirebaseFirestore.instance
        .collection("users")
        .doc("${items[3].toString()}")
        .update({
      'Name': name.text,
      'mobile': mobile.text,
      'zone': zone.text
    }).then((value) {
      name.clear();
      mobile.clear();
      zone.clear();
    });
  }

  Widget build(BuildContext context) {
    return isloaded
        ? Scaffold(
            appBar: AppBar(
              title: Text("EDIT ACCOUNT"),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: name,
                      decoration: const InputDecoration(hintText: "NAME"),
                    ),
                    spacer10(),
                    TextField(
                      controller: mobile,
                      decoration:
                          const InputDecoration(hintText: "MOBILE NUMBER"),
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                    ),
                    spacer10(),
                    TextField(
                      controller: zone,
                      decoration: const InputDecoration(hintText: "ZONE"),
                    ),
                    spacer10(),
                    ElevatedButton(
                      onPressed: () {
                        if (name.text.isNotEmpty &&
                            mobile.text.isNotEmpty &&
                            zone.text.isNotEmpty) {
                          Edit();
                        } else {
                          print('error');
                          const snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            elevation: 10,
                            behavior: SnackBarBehavior.floating,
                            content: Text('Fields Connot be Empty!'),
                            showCloseIcon: true,
                            duration: Duration(seconds: 3),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Text("SUBMIT"),
                    )
                  ],
                ),
              ),
            ),
          )
        : Container();
  }
}
