import 'package:flora1/db/db_functions/db_functions.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Qr_page extends StatefulWidget {
  const Qr_page({super.key});

  @override
  State<Qr_page> createState() => _Qr_pageState();
}

class _Qr_pageState extends State<Qr_page> {
  var user_id1;
  late List<Map> table = [];
  Future<void> getuser() async {
    table = (await db.rawQuery('SELECT (User_id) FROM User_Info'));
    setState(() {
      user_id1 = table
          .elementAt(0)
          .values
          .toString()
          .replaceAll('(', '')
          .replaceAll(')', '');
    });
    print(user_id);
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getuser();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                user_id1.toString().isEmpty
                    ? Container()
                    : QrImageView(
                        data: "${user_id1}",
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
              ],
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Customer Id: ${user_id1}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                    width: double.infinity,
                  ),
                  Text(
                    "You can either scan the above QR code or Manually enter the customer Id",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
