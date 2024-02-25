import 'package:flora1/colors.dart';
import 'package:flora1/qr_Scanner.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  var collection = FirebaseFirestore.instance.collection("users");
  late List<Map<String, dynamic>> items = [];
  bool isloaded = false;
// var data = await collection.doc("userid").get();
  _call() async {
    List<Map<String, dynamic>> templist = [];

    var data = await collection.get();

    data.docs.forEach((element) {
      templist.add(element.data());
    });

    setState(() {
      items = templist;
      isloaded = true;
    });

    print(items.length.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListView(
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
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100))),
                                  //inner circle1
                                  child: const Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Your Level',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 169, 64, 254)),
                                        ),
                                        Text(
                                          '1',
                                          style: TextStyle(
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
                          child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '1.0Kg',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                          color: text_color,
                                          letterSpacing: 0),
                                    ),
                                    Text(
                                      'Plastic Collected',
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '01/12/24',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                          color: text_color,
                                          letterSpacing: 0),
                                    ),
                                    Text(
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
                              onPressed: () {},
                              child: const Icon(Icons.energy_savings_leaf),
                            ),
                            FloatingActionButton(
                              onPressed: () {},
                              child: const Icon(Icons.account_circle_outlined),
                            ),
                            FloatingActionButton(
                              onPressed: () {},
                              child: const Icon(Icons.add_ic_call_outlined),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FloatingActionButton(
                              onPressed: () {},
                              child:
                                  const Icon(Icons.add_shopping_cart_rounded),
                            ),
                            FloatingActionButton(
                              onPressed: () {},
                              child: const Icon(Icons.analytics_outlined),
                            ),
                            FloatingActionButton(
                              onPressed: () {},
                              child: const Icon(Icons.abc),
                            ),
                            FloatingActionButton(
                              onPressed: () {},
                              child: const Icon(Icons.abc),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
