// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:homeversity_staff/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final firestoreInstance = FirebaseFirestore.instance;

    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   FirebaseFirestore.instance
      //       .collection("attendanceList")
      //       .where("code", isEqualTo: 71145)
      //       .orderBy("createdAt", descending: true)
      //       .limit(1)
      //       .get()
      //       .then((value) {
      //     print(value.docs[0].id);
      //     firestoreInstance
      //         .collection("attendanceList")
      //         .doc(value.docs[0].id)
      //         .update({
      //       "students": FieldValue.arrayUnion([
      //         {"registerNumber": 123004013, "name": "Madhavan"}
      //       ])
      //     });
      //     firestoreInstance.collection("studentsList").doc("123004013").set({
      //       "subName": FieldValue.arrayUnion([
      //         {
      //           "subName": value.docs[0].data()["subName"],
      //           "createdAt": value.docs[0].data()["createdAt"],
      //           "section": value.docs[0].data()["section"]
      //         }
      //       ])
      //     });
      //   }).then((value) => print("posted"));
      //   // firestoreInstance
      //   //     .collection("attendanceList")
      //   //     .where("code", isEqualTo: 49833)
      //   //     .orderBy("createdAt", descending: true)
      //   //     .limit(1)
      //   //     .get()
      //   //     .then((value) {
      //   //   print(value.docs[0].data()["students"]);
      //   // });
      // }),
      appBar: AppBar(
        title: const Text('Home'),
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
              "Good Morning, Akil!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Active Attendance Code",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("codes").snapshots(),
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
                          child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Container(
                          height: 140,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(
                                    0.0,
                                    0.0,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      document["code"].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection("codes")
                                            .doc(document.id)
                                            .delete();
                                        const snackBar = SnackBar(
                                          content: Text('Code Deleted'),
                                        );

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      },
                                      icon: Icon(
                                        Icons.delete_outline,
                                        size: 30,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  document["subName"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xff1e5eff)),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  document["createdAt"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
                    }).toList(),
                  );
                }),
          ],
        ),
      )),
    );
  }
}
