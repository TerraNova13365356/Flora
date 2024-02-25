import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flora1/Utilities/Utilities.dart';
import 'package:flora1/colors.dart';
import 'package:flora1/home.dart';
import 'package:flora1/login_page.dart';
import 'package:flora1/sign_up/sign_up_page_User_info.dart';
import 'package:flutter/material.dart';

String User_name = '';

// ignore: camel_case_types
class Sign_In_Page extends StatefulWidget {
  const Sign_In_Page({super.key});

  @override
  State<Sign_In_Page> createState() => _Sign_In_PageState();
}

class _Sign_In_PageState extends State<Sign_In_Page> {
  var collection = FirebaseFirestore.instance.collection("User_credentials");
  final TextEditingController user_name = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController con_password = TextEditingController();
  final _globalKey = GlobalKey<ScaffoldMessengerState>();
  late bool _confirmPasswordVisible;
  late bool _passwordVisible;
  Future<void> add_user() async {
    final user_data = {
      'User_name': user_name.text,
      'password': password.text,
      'user_id': "null"
    };
    if (user_name.text.isNotEmpty &&
        password.text.isNotEmpty &&
        (password.text == con_password.text)) {
      final check = await collection.doc(user_name.text).get();

      if (check == null || !check.exists) {
        collection.doc(user_name.text).set(user_data).then((value) {
          User_name = user_name.text;
          user_name.clear();
          password.clear();
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return const Sign_Up_User_info();
          }));
        });
      } else {
        Alert_box('User Name already Exists').show(context);
      }
    } else {
      Alert_box('Fields cannot be Empty! or passwords does not matching')
          .show(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _confirmPasswordVisible = true;
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(children: [
        Container(
            height: screen.height * 0.5,
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  width: screen.width * 0.7,
                  height: screen.width * 0.7,
                  decoration: const BoxDecoration(
                      color: pri_color1,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(250),
                          bottomLeft: Radius.circular(0))),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 70, horizontal: 30),
                  child: Text(
                    'Welcome',
                    style: TextStyle(
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
                  prefixIcon: const Icon(Icons.lock),
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
              TextField(
                obscureText: _confirmPasswordVisible,
                controller: con_password,
                decoration: InputDecoration(
                  hintText: "confirm Password",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const spacer10(),
              ElevatedButton(
                  onPressed: () {
                    add_user();
                  },
                  child: const Text('Sign up'),
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: const Color.fromARGB(255, 34, 233, 16))),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("Already Sign in?"),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (ctx) {
                          return const login_page();
                        }));
                      },
                      child: const Text("Go to Login"))
                ],
              )
            ],
          ),
        ))
      ]),
    );
  }
}
