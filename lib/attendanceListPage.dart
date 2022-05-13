// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeversity_staff/widgets/drawer.dart';
import 'package:homeversity_staff/widgets/historyCard.dart';

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
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   FirebaseFirestore.instance
      //       .collection("attendanceList")
      //       .where("code", isEqualTo: widget.code)
      //       .orderBy("createdAt", descending: true)
      //       .limit(1)
      //       .get()
      //       .then((value) {
      //     print(value.docs[0].data()["students"]);
      //   });
      // }),
      appBar: AppBar(
        title: const Text('Homeversity Staff Portal'),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("attendanceList")
                  .where("code", isEqualTo: widget.code)
                  .orderBy("createdAt", descending: true)
                  .limit(1)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((document) {
                    return Center(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: document["students"].length,
                            itemBuilder: (BuildContext context, int index) {
                              return SessionCard(
                                  subName: document["students"][index]["name"],
                                  year: document["students"][index]
                                          ["registerNumber"]
                                      .toString(),
                                  section: '',
                                  timeStamp: document["students"][index]["time"]
                                      .toString());
                            }));
                  }).toList(),
                );
              }),
        ]),
      )),
    );
  }
}
