import 'package:flora1/Utilities/Utilities.dart';
import 'package:flutter/material.dart';

class Help_support extends StatelessWidget {
  const Help_support({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help and Support"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1.FAQs:",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text("Find quick answers to common questions.\n\t\t[Go to FAQs]"),
              spacer10(),
              Text(
                "2.Contact Us:",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text(
                  "Need assistance? Reach out to our support team.\n\t\tEmail:terranova13365356@gmail.com"),
              spacer10(),
              Text(
                "3.Feedback:",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text(
                  "Share your thoughts or report issues.\n\t\t[Provide Feedback]"),
            ],
          ),
        ),
      ),
    );
  }
}
