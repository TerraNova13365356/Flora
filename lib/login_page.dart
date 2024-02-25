import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flora1/Utilities/Utilities.dart';
import 'package:flora1/colors.dart';
import 'package:flora1/db/db_functions/db_functions.dart';
import 'package:flora1/forgot_pass.dart';
import 'package:flora1/home.dart';
import 'package:flora1/sign_up/sign_in_page.dart';
import 'package:flora1/splash_screen.dart';
import 'package:flutter/material.dart';

DocumentSnapshot? snapshot;

// ignore: camel_case_types
class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  var radius_right_data;
  var radius_left_data;

  late String text_ms;
  var collection = FirebaseFirestore.instance.collection("User_credentials");

  final TextEditingController user_name = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future login() async {
    final check = await collection.doc(user_name.text).get();

    if (check == null || !check.exists) {
      print("no user");
      // ignore: use_build_context_synchronously
      Alert_box('No Such Username').show(context);
    } else {
      if (check["password"] == password.text) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
          if (isSigned) {
          } else {
            create_user('', '', '', '', check["user_id"]);
            print(check["user_id"]);
          }
          return const Home();
        }));
      } else {
        Alert_box('Incorrect Password').show(context);
      }
    }
  }

  late bool _passwordVisible;
  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  @override
  // void getdata() {
  //   print("jkdknf");
  //   // final data = await FirebaseFirestore.instance
  //   //     .collection('users')
  //   //     .doc('userid')
  //   //     .get();
  //   // snapshot = data;

  //   // print(snapshot);
  // }

  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var _process_identi = 0;
    var align_data;
    if (_process_identi == 0) {
      align_data = Alignment.topLeft;
      radius_right_data = const Radius.circular(250);
      radius_left_data = const Radius.circular(0);
      text_ms = "Welcome\nBack!";
    } else {
      align_data = Alignment.topRight;
      radius_right_data = const Radius.circular(0);
      radius_left_data = const Radius.circular(250);
      text_ms = "Welcome!";
    }
    return Scaffold(
      body: ListView(children: [
        Container(
            height: screen.height * 0.5,
            child: Stack(
              alignment: align_data,
              children: [
                Container(
                  width: screen.width * 0.7,
                  height: screen.width * 0.7,
                  decoration: BoxDecoration(
                      color: pri_color1,
                      borderRadius: BorderRadius.only(
                          bottomRight: radius_right_data,
                          bottomLeft: radius_left_data)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 70, horizontal: 30),
                  child: Text(
                    '$text_ms',
                    style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(244, 255, 255, 255)),
                  ),
                ),
              ],
            )),
        Container(
            child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          child: Column(
            children: [
              TextField(
                controller: user_name,
                decoration: const InputDecoration(
                  hintText: "User name",
                  prefixIcon: Icon(Icons.account_circle_rounded),
                ),
              ),
              TextField(
                obscureText: _passwordVisible,
                controller: password,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return Forgot_password();
                        }));
                      },
                      child: const Text('Forget Password?',
                          style: TextStyle(color: Colors.red)))
                ],
              ),
              const spacer10(),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (user_name.text.isNotEmpty && password.text.isNotEmpty) {
                      login();
                    } else {
                      Alert_box('Fields are Empty').show(context);
                    }
                  },
                  child: const Text('Log in'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: const Color.fromARGB(255, 34, 233, 16),
                  )),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Text('OR'),
                  Expanded(child: Divider())
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (ctx) {
                    return const Sign_In_Page();
                  }));
                },
                child: const Text('Sign up'),
                style: ElevatedButton.styleFrom(
                    foregroundColor: pri_color1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            width: 2,
                            color: const Color.fromARGB(255, 34, 233, 16))),
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.white),
              )
            ],
          ),
        )),
      ]),
    );
  }
}
