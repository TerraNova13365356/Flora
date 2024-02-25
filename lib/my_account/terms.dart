import 'package:flora1/Utilities/Utilities.dart';
import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Terms And Conditions")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            head("Terms and Conditions"),
            head("Last updated: [Date]"),
            head("Welcome to Flora!"),
            para(
                "These Terms and Conditions (\"Terms\") govern your access and use of Flora (\"App\"), a mobile application developed and operated by [Your Company Name]. Please read these Terms carefully before using the App. By accessing or using the App, you agree to be bound by these Terms and all applicable laws and regulations. If you disagree with any part of these Terms, you may not access or use the App."),
            head("1. Definitions"),
            spacer10(),
            para(
                "\"You\" or \"User\" refers to the individual person accessing or using the App.\n\"Content\" refers to any text, graphics, images, audio, video, or other information or materials uploaded, submitted, or otherwise provided by Users to the App\n\"Service\" refers to the features and functionalities offered by the App."),
            head("2. Your Use of Flora"),
            spacer10(),
            para(
                "You agree to use Flora in a lawful and responsible manner.You are prohibited from using Flora for any purpose that is unlawful or prohibited by these Terms.This includes, but is not limited to:Infringing on the intellectual property rights of others.Transmitting or storing illegal or harmful content.Disrupting or abusing Flora or its Services.Impersonating any person or entity.Violating the privacy of others."),
            head("3. Intellectual Property"),
            spacer10(),
            para(
                "Flora and its Services are protected by intellectual property laws, including copyrights, trademarks, and patents.All rights to Flora and its Services are reserved by [Your Company Name].You may not use any trademarks or copyrighted materials of [Your Company Name] without our express written permission"),
            head("4. Privacy Policy"),
            spacer10(),
            para(
                "Please refer to our Privacy Policy for details on how we collect, use, and disclose your personal information.")
          ],
        ),
      ),
    );
  }

  Text para(String head) {
    return Text(
      head,
      style: TextStyle(
        fontSize: 13,
      ),
    );
  }

  Text head(String para) {
    return Text(
      para,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
