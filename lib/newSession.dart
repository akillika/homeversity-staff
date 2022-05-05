// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:homeversity_staff/main.dart';
import 'package:homeversity_staff/widgets/drawer.dart';

class NewSessionpage extends StatefulWidget {
  const NewSessionpage({Key? key}) : super(key: key);

  @override
  State<NewSessionpage> createState() => _NewSessionpageState();
}

class _NewSessionpageState extends State<NewSessionpage> {
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
            GestureDetector(
              onTap: () {
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(builder: (context) => HomePage()),
                //   (Route<dynamic> route) => false,
                // );
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
