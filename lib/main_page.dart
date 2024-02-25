import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flora1/colors.dart';
import 'package:flora1/db/db_functions/db_functions.dart';
import 'package:flora1/maths/math_func.dart';
import 'package:flora1/progress_page/progress_page.dart';
import 'package:flora1/qr_Scanner.dart';
import 'package:flutter/material.dart';

int currentStage = 0;

class Main_page extends StatefulWidget {
  const Main_page({
    super.key,
    required this.pri_color,
  });

  final Color pri_color;

  @override
  State<Main_page> createState() => _Main_pageState();
}

CollectionReference ref = FirebaseFirestore.instance.collection("users");

class _Main_pageState extends State<Main_page> {
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
    templist.add(data["current_stage"]);
    templist.add(data["last_collected_date"]);
    templist.add(data["plastic_collected"]);
    setState(() {
      items = templist;
      isloaded = true;
    });
    currentStage = items[0];
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
        ? StreamBuilder(
            stream: collection.snapshots(),
            builder: (context, index) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(color: pri_color1),
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Center(
                        child: Container(
                          width: 190,
                          height: 190,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(92, 255, 255, 255),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(170))),
                          child: Center(
                            child: Container(
                              width: 140,
                              height: 140,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(97, 255, 255, 255),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              child: Center(
                                child: Center(
                                  child: Container(
                                    //inner circle2
                                    width: 120,
                                    height: 120,
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                    //inner circle1
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Your Level',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 169, 64, 254)),
                                          ),
                                          Text(
                                            level_calc(items[0]).toString(),
                                            style: const TextStyle(
                                                fontSize: 45,
                                                fontWeight: FontWeight.w900,
                                                color: Color.fromARGB(
                                                    255, 147, 15, 254),
                                                fontFamily:
                                                    AutofillHints.birthdayDay),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 100,
                          decoration: const BoxDecoration(
                              color: pri_color1,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15))),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(84, 6, 6, 6),
                                    blurRadius: 16.0,
                                    offset: Offset(0, 3))
                              ],
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 150,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        (items[2].toString()) + 'Kg',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                            color: text_color,
                                            letterSpacing: 0),
                                      ),
                                      const Text(
                                        'Plastic Collected',
                                        style: TextStyle(fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        next_date(items[1]),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                            color: text_color,
                                            letterSpacing: 0),
                                      ),
                                      const Text(
                                        'Next collection date',
                                        style: TextStyle(fontSize: 15),
                                      )
                                    ],
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 200,
                      decoration: const BoxDecoration(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FloatingActionButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (ctx) {
                                    return const Qr_Scanner();
                                  }));
                                },
                                child: const Icon(
                                  Icons.qr_code_scanner,
                                ),
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (ctx) {
                                    return ProgressionPage();
                                  }));
                                },
                                child: const Icon(Icons.track_changes),
                              ),
                              FloatingActionButton(
                                onPressed: () {},
                                child: const Icon(Icons.add_ic_call_outlined),
                              ),
                              FloatingActionButton(
                                onPressed: () {},
                                child: const Icon(Icons.feedback),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            })
        : Container();
  }
}
