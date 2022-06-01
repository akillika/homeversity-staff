// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeversity_staff/attendanceListPage.dart';
import 'package:homeversity_staff/widgets/drawer.dart';
import 'package:homeversity_staff/widgets/historyCard.dart';

class SessionHistoryPage extends StatefulWidget {
  const SessionHistoryPage({Key? key}) : super(key: key);

  @override
  State<SessionHistoryPage> createState() => _SessionHistoryPageState();
}

class _SessionHistoryPageState extends State<SessionHistoryPage> {
  @override
  Widget build(BuildContext context) {
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
              "Session History",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('attendanceList')
                    .where("staff", isEqualTo: "akillika49@gmail.com")
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
                          child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AttendanceListPage(
                                      id: document["id"].toString(),
                                      timeStamp: document["createdAt"])));
                        },
                        child: SessionCard(
                            subName: document["subName"],
                            year: document["year"],
                            section: document["section"],
                            timeStamp: document["createdAt"]),
                      ));
                    }).toList(),
                  );
                }),
            // Text(
            //   "April 18, 2020",
            //   style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       fontSize: 12,
            //       color: Colors.black54),
            // ),
            SizedBox(
              height: 20,
            ),
            // ListView.builder(
            //     itemCount: 3,
            //     shrinkWrap: true,
            //     itemBuilder: (context, index) {
            //       return SessionCard();
            //     })
          ],
        ),
      )),
    );
  }
}
