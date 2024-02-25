import 'package:flora1/Qr_page.dart';
import 'package:flora1/ac.dart';
import 'package:flora1/colors.dart';
import 'package:flora1/main_page.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

int _selectedbpx = 0;
List _pages = [
  const Main_page(pri_color: pri_color1),
  const Qr_page(),
  const Account_page()
];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    void tap(int index) {
      setState(() {
        _selectedbpx = index;
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flora'),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        body: Center(
          child: _pages.elementAt(_selectedbpx),
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedbpx,
            onTap: tap,
            selectedItemColor: text_color,
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedIconTheme: const IconThemeData(opacity: 0.5),
            selectedIconTheme: const IconThemeData(opacity: 1),
            selectedFontSize: 15.0,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.qr_code), label: "Qr code"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: "Account"),
            ]),
      ),
    );
  }
}
