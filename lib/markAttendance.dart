// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeversity_staff/main.dart';
import 'package:homeversity_staff/widgets/drawer.dart';

class MarkAttendance extends StatefulWidget {
  const MarkAttendance({Key? key}) : super(key: key);

  @override
  State<MarkAttendance> createState() => _MarkAttendanceState();
}

class _MarkAttendanceState extends State<MarkAttendance> {
  @override
  Widget build(BuildContext context) {
    TextEditingController codeController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homeversity Staff Portal'),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              "Mark your attendance",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: codeController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Code provided by your staff",
                  fillColor: Colors.white70),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                FirebaseFirestore.instance
                    .collection("attendanceList")
                    .where("code", isEqualTo: int.tryParse(codeController.text))
                    .orderBy("createdAt", descending: true)
                    .limit(1)
                    .get()
                    .then((value) {
                  if (value.docs.isNotEmpty) {
                    print(value.docs[0].id);
                    FirebaseFirestore.instance
                        .collection("attendanceList")
                        .doc(value.docs[0].id)
                        .update({
                      "students": FieldValue.arrayUnion([
                        {
                          "registerNumber": 123004013,
                          "name": "Madhavan",
                          "time": DateTime.now().toString()
                        }
                      ])
                    });
                    FirebaseFirestore.instance
                        .collection("studentsList")
                        .doc("123004013")
                        .update({
                      "sessions": FieldValue.arrayUnion([
                        {
                          "subName": value.docs[0].data()["subName"],
                          "createdAt": DateTime.now().toString(),
                          "section": value.docs[0].data()["section"]
                        }
                      ])
                    });
                  } else {
                    print("Enter valid Code");
                  }
                }).then((value) => print(" request completed"));
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: customColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                    child: Text(
                  "Mark attendance",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                )),
              ),
            )
          ],
        ),
      )),
    );
  }
}
