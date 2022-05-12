// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeversity_staff/widgets/drawer.dart';

class AttendanceListPage extends StatefulWidget {
  final int code;
  final String timeStamp;

  const AttendanceListPage(
      {Key? key, required this.code, required this.timeStamp})
      : super(key: key);

  @override
  State<AttendanceListPage> createState() => _AttendanceListPageState();
}

class _AttendanceListPageState extends State<AttendanceListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        FirebaseFirestore.instance
            .collection("attendanceList")
            .where("code", isEqualTo: widget.code)
            .orderBy("createdAt", descending: true)
            .limit(1)
            .get()
            .then((value) {
          print(value.docs[0].data()["students"]);
        });
      }),
      appBar: AppBar(
        title: const Text('Homeversity Staff Portal'),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: []),
      )),
    );
  }
}
