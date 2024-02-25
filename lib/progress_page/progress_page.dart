import 'dart:ui';

import 'package:flora1/Utilities/Utilities.dart';
import 'package:flora1/colors.dart';
import 'package:flora1/main_page.dart';
import 'package:flora1/maths/math_func.dart';
import 'package:flutter/material.dart';

int level = 0;

class ProgressionPage extends StatefulWidget {
  @override
  _ProgressionPageState createState() => _ProgressionPageState();
}

class _ProgressionPageState extends State<ProgressionPage>
    with SingleTickerProviderStateMixin {
  int _progress = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    setState(() {
      level = level_calc(currentStage)!;
      _progress = (currentStage % 10) * 10;
      for (var i = 0; i < level; i++) {
        blur_image[i] = false;
      }
      for (var i = 0; i < level; i++) {
        opacity[i] = 0;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<bool> blur_image = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];

  List<double> opacity = [
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
  ];
  void _increaseProgress() {
    setState(() {
      _progress += 10;
      if (_progress > 100) _progress = 100;
      _controller.forward(from: 0); // Start animation from the beginning
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Progress'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.green[50],
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 100,
                child: Text(
                  "1",
                  style: TextStyle(fontSize: 80, fontWeight: FontWeight.w900),
                ),
              ),
              spacer10(),
              Text(
                '$_progress% Completed to reach next level',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                ),
              ),
              SizedBox(height: 20),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: _progress / 100,
                    backgroundColor: Colors.green[200],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  );
                },
              ),
              SizedBox(height: 40),
              cards("assets/images/img1.jpg", "assets/images/im2.jpg", "1", "2",
                  blur_image[0], blur_image[1], opacity[0], opacity[1]),
              spacer10(),
              cards("assets/images/img3.jpg", "assets/images/img4.jpg", "3",
                  "4", blur_image[2], blur_image[3], opacity[2], opacity[3]),
              spacer10(),
              cards("assets/images/img5.jpg", "assets/images/img6.jpg", "5",
                  "6", blur_image[4], blur_image[5], opacity[4], opacity[5]),
              spacer10(),
              cards("assets/images/img7.jpg", "assets/images/img8.jpg", "7",
                  "8", blur_image[6], blur_image[7], opacity[6], opacity[7]),
              spacer10(),
              cards("assets/images/img9.jpg", "assets/images/img10.jpg", "9",
                  "10", blur_image[8], blur_image[9], opacity[8], opacity[9]),
            ],
          ),
        ),
      ),
    );
  }

  Row cards(String img1, String img2, String img1_level, String img2_level,
      bool img1_blur, bool img2_blur, double op1, double op2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
                decoration: BoxDecoration(border: Border.all()),
                height: 150,
                width: 150,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Image.asset(
                    img1,
                    fit: BoxFit.cover,
                  ),
                  enabled: img1_blur,
                )),
            Opacity(
              opacity: op1,
              child: Text(
                "Reach level ${img1_level}",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
              ),
            )
          ],
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
                decoration: BoxDecoration(border: Border.all()),
                height: 150,
                width: 150,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Image.asset(
                    img2,
                    fit: BoxFit.cover,
                  ),
                  enabled: img2_blur,
                )),
            Opacity(
              opacity: op2,
              child: Text(
                "Reach level ${img2_level}",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
              ),
            )
          ],
        ),
      ],
    );
  }
}
