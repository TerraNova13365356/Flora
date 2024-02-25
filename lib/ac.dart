import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flora1/db/db_functions/db_functions.dart';
import 'package:flora1/login_page.dart';
import 'package:flora1/my_account/edit_acc.dart';
import 'package:flora1/my_account/help.dart';
import 'package:flora1/my_account/history.dart';
import 'package:flora1/my_account/personal_info.dart';
import 'package:flora1/my_account/terms.dart';
import 'package:flutter/material.dart';

var user;
List items = [];

class Account_page extends StatefulWidget {
  const Account_page({Key? key}) : super(key: key);

  @override
  State<Account_page> createState() => _Account_pageState();
}

class _Account_pageState extends State<Account_page> {
  var collection = FirebaseFirestore.instance.collection("users");

  List count = [0];

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
    templist.add(data["User_id"]);
    setState(() {
      items = templist;
      isloaded = true;
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log out?'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure, you want to logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                Delete(items[3].toString()).then((value) {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (ctx) {
                    return const login_page();
                  }));
                });
              },
            ),
          ],
        );
      },
    );
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
            body: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: CircleAvatar(
                        backgroundColor: Colors.lightGreen,
                        radius: 90,
                        child: Text(
                          items[0].toString().substring(0, 1).toUpperCase(),
                          style: TextStyle(fontSize: 60),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${items[0]}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  //-----------------------row1
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(children: [
                        Icon(
                          Icons.account_circle_sharp,
                          color: Colors.grey,
                          size: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Personal info',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return const personal_info();
                                }));
                              },
                              icon: const Icon(
                                Icons.arrow_right_outlined,
                                color: Colors.grey,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                //-------------------------------------------------------------------
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(children: [
                        Icon(
                          Icons.lock,
                          color: Colors.grey,
                          size: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Edit Account',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return Edit_acc();
                                }));
                              },
                              icon: const Icon(
                                Icons.arrow_right_outlined,
                                color: Colors.grey,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                //------------------------------------------------------------------

                //------------------------------------------------------------------
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(children: [
                        Icon(
                          Icons.history,
                          color: Colors.grey,
                          size: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Plastic collection history',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return const Collection_history();
                                }));
                              },
                              icon: const Icon(
                                Icons.arrow_right_outlined,
                                color: Colors.grey,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                //------------------------------------------------------------------

                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(children: [
                        Icon(
                          Icons.help,
                          color: Colors.grey,
                          size: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Help and support',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return const Help_support();
                                }));
                              },
                              icon: const Icon(
                                Icons.arrow_right_outlined,
                                color: Colors.grey,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(children: [
                        Icon(
                          Icons.description,
                          color: Colors.grey,
                          size: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Terms of Service',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return const Terms();
                                }));
                              },
                              icon: const Icon(
                                Icons.arrow_right_outlined,
                                color: Colors.grey,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(children: [
                        Icon(
                          Icons.logout,
                          color: Colors.grey,
                          size: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Log Out',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                _showMyDialog();
                                // Delete(items[3].toString()).then((value) {
                                //   Navigator.of(context)
                                //       .push(MaterialPageRoute(builder: (ctx) {
                                //     return const login_page();
                                //   }));
                                // });
                              },
                              icon: const Icon(
                                Icons.arrow_right_outlined,
                                color: Colors.grey,
                              ))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        : Container();
  }
}
