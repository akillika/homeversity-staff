  /// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';

import 'package:flutter/material.dart';
import 'package:homeversity_staff/widgets/drawer.dart';
import 'package:homeversity_staff/widgets/historyCard.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_string/random_string.dart';

class AttendanceListPage extends StatefulWidget {
  final String id;
  final String timeStamp;

  const AttendanceListPage(
      {Key? key, required this.id, required this.timeStamp})
      : super(key: key);

  @override
  State<AttendanceListPage> createState() => _AttendanceListPageState();
}

class _AttendanceListPageState extends State<AttendanceListPage> {
  @override
  void initState() {
    print(widget.id);
    super.initState();
  }

  void generatePDF(List<List<String>> data)async{
    // List<List<String>> data = [
    //   ["No.", "Name", "Roll No."],
    //   ["1", randomAlpha(3), randomNumeric(3)],
    //   ["2", randomAlpha(3), randomNumeric(3)],
    //   ["3", randomAlpha(3), randomNumeric(3)]
    // ];
    String csvData = const ListToCsvConverter().convert(data);
    final String directory =
    (await getApplicationSupportDirectory()).path;
    final path = "$directory/csv-${DateTime.now()}.csv";
    print(path);
    final File file = File(path);
    await file.writeAsString(csvData);

    print("stored");
  }

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
        actions: [
          GestureDetector(
              onTap: () async {
                List<List<String>> data = [
                  ["No.", "Name", "Roll No."],
                  ["1", randomAlpha(3), randomNumeric(3)],
                  ["2", randomAlpha(3), randomNumeric(3)],
                  ["3", randomAlpha(3), randomNumeric(3)]
                ];
                String csvData = const ListToCsvConverter().convert(data);
                final String directory =
                    (await getApplicationSupportDirectory()).path;
                final path = "$directory/csv-${DateTime.now()}.csv";
                print(path);
                final File file = File(path);
                await file.writeAsString(csvData);

                print("stored");
              },
              child: const Icon(Icons.download))
        ],
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("attendanceList")
                  .where("id", isEqualTo: widget.id)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((document) {
                    return Center(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: document["attendees"].length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: (){
                                  generatePDF(document["attendees"]);
                                },
                                child: SessionCard(
                                    subName: document["attendees"][index]["name"],
                                    year: document["attendees"][index]
                                            ["registerNumber"]
                                        .toString(),
                                    section: '',
                                    timeStamp: document["attendees"][index]
                                            ["time"]
                                        .toString()),
                              );
                            }));
                  }).toList(),
                );
              }),
        ]),
      )),
    );
  }
}
