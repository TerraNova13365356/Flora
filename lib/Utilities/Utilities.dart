import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class spacer10 extends StatelessWidget {
  const spacer10({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
    );
  }
}

Flushbar<dynamic> Alert_box(String ms) {
  return Flushbar(
    message: ms,
    icon: Icon(
      Icons.info_outline,
      size: 28.0,
      color: Color.fromARGB(255, 255, 0, 0),
    ),
    duration: const Duration(seconds: 2),
    leftBarIndicatorColor: Colors.blue[300],
  );
}
