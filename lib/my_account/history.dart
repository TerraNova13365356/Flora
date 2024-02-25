import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flora1/Utilities/Utilities.dart';
import 'package:flora1/ac.dart';
import 'package:flora1/colors.dart';
import 'package:flutter/material.dart';

class Collection_history extends StatefulWidget {
  const Collection_history({super.key});

  @override
  State<Collection_history> createState() => _Collection_historyState();
}

class _Collection_historyState extends State<Collection_history> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection("users/${items[3].toString()}/collection_info");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Collection History"),
      ),
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot listsnap = snapshot.data.docs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: pri_color1,
                          border: Border.all(
                              width: 1,
                              color: Color.fromARGB(255, 39, 122, 255)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                "Date: " + listsnap["collection_date"],
                                style: TextStyle(
                                    fontSize: 16, color: Colors.blue[700]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CircleAvatar(
                                radius: 30,
                                child: Text(listsnap["Weight"] + "Kg"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      spacer10(),
                    ],
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
