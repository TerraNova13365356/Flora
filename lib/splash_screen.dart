import 'package:flora1/db/db_functions/db_functions.dart';
import 'package:flora1/home.dart';
import 'package:flora1/login_page.dart';
import 'package:flutter/material.dart';

bool isSigned = false;

// ignore: camel_case_types
class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    // TODO: implement initState
    gotologin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo3.png',
                      width: 200,
                      height: 200,
                    ),
                    const Text(
                      "Flora",
                      style: TextStyle(
                          fontFamily: AutofillHints.birthday,
                          fontWeight: FontWeight.w800,
                          fontSize: 40,
                          color: Color.fromARGB(255, 118, 158, 16)),
                    )
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Heaven is under our feet as well as over our heads",
                      style: TextStyle(
                          fontSize: 15, color: Color.fromARGB(255, 14, 91, 22)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 7),
                          child: Text(
                            "—Henry David Thoreau",
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Container(
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Loading..",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 14, 91, 22),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ))
        ],
      )),
    );
  }

  Future<void> gotologin() async {
    await Future.delayed(const Duration(seconds: 3));
    List<Map> table = (await db.rawQuery('SELECT * FROM User_Info'));
    print(table.isNotEmpty);

    if (table.isNotEmpty) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => Home()));
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => login_page()));
    }
  }
}
