// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';
import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homeversity_staff/main.dart';
import 'package:homeversity_staff/widgets/drawer.dart';
import 'package:uuid/uuid.dart';

class NewSessionpage extends StatefulWidget {
  const NewSessionpage({Key? key}) : super(key: key);

  @override
  State<NewSessionpage> createState() => _NewSessionpageState();
}

class _NewSessionpageState extends State<NewSessionpage> {
  BeaconBroadcast beaconBroadcast = BeaconBroadcast();
  @override
  Widget build(BuildContext context) {
    final firestoreInstance = FirebaseFirestore.instance;
    TextEditingController subNameController = TextEditingController();
    TextEditingController yearController = TextEditingController();
    TextEditingController sectionController = TextEditingController();

    checkCodeExists(
        String subName, String year, String section, String beaconUuid) async {
      int generatedcode = 10000 + Random().nextInt(99999 - 10000);
      firestoreInstance
          .collection("codes")
          .doc(generatedcode.toString())
          .get()
          .then((value) {
        if (value.exists) {
          print("exists");
          generatedcode = 10000 + Random().nextInt(99999 - 10000);
          checkCodeExists(subName, year, section, beaconUuid);
        } else {
          firestoreInstance
              .collection("codes")
              .doc(generatedcode.toString())
              .set({
            "code": generatedcode,
            "subName": subName,
            "year": year,
            "section": section,
            "createdAt": DateTime.now().toString(),
            "staff": FirebaseAuth.instance.currentUser!.email,
            "id": Uuid().v1(),
            "beaconUuid": beaconUuid,
          }).then((value) => print("posted"));
          // firestoreInstance.collection("attendanceList").add({
          //   "code": generatedcode,
          //   "subName": subName,
          //   "year": year,
          //   "section": section,
          //   "createdAt": DateTime.now().toString(),
          //   "staff": FirebaseAuth.instance.currentUser!.email,
          //   "id": Uuid().v1()
          // });
          SnackBar snackBar = SnackBar(
            content: Text("Code generated"),
            duration: Duration(seconds: 1),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (() {
        beaconBroadcast.stop();
      })),
      appBar: AppBar(
        title: const Text('Homeversity Staff Portal'),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              "Create a new session",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: subNameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Subject Name (Visible to students)",
                  fillColor: Colors.white70),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: yearController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Year and Dept (Visible to students)",
                  fillColor: Colors.white70),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: sectionController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Section (Visible to students)",
                  fillColor: Colors.white70),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                var beaconUuid = Uuid().v1();
                checkCodeExists(subNameController.text, yearController.text,
                    sectionController.text, beaconUuid);

                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => BeaconPage()));
                // var status = await Permission.bluetooth.status;
                // status = await Permission.bluetoothAdvertise.status;
                // status = await Permission.bluetoothConnect.status;
                // status = await Permission.bluetoothScan.status;

                // print("Status: $status");

                print(beaconUuid);
                beaconBroadcast
                    .setUUID(beaconUuid)
                    .setMajorId(1)
                    .setMinorId(100)
                    .start();
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: customColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                    child: Text(
                  "Create",
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
