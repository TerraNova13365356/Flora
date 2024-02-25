// ignore: non_constant_identifier_names
// PrettyQrView.data(
//   data: 'lorem ipsum dolor sit amet',
//   decoration: const PrettyQrDecoration(
//     image: PrettyQrDecorationImage(
//       image: AssetImage('images/flutter.png'),
//     ),
//   ),
// )

import 'package:flora1/scanner_con.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

String scan_result = "";

class Qr_Scanner extends StatefulWidget {
  const Qr_Scanner({super.key});

  @override
  State<Qr_Scanner> createState() => _Qr_ScannerState();
}

class _Qr_ScannerState extends State<Qr_Scanner> {
  start_scan() async {
    var result;

    try {
      result = await FlutterBarcodeScanner.scanBarcode(
          '#FFFFFF', 'Stop scan', true, ScanMode.QR);
    } on PlatformException catch (e) {
      result = "Unable to scan ,Please try Again";
      print(e);
    }
    if (!mounted) return;
    setState(() {
      scan_result = result;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
        return const Scanner_info();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Scanner",
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
                width: double.infinity,
              ),
              ElevatedButton(
                  onPressed: () {
                    start_scan();
                  },
                  child: Text("Scan"))
            ],
          ),
        ),
      ),
    );
  }
}
