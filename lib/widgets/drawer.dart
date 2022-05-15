// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:homeversity_staff/authenticationHelper.dart';
import 'package:homeversity_staff/loginPage.dart';
import 'package:homeversity_staff/markAttendance.dart';
import 'package:homeversity_staff/sessionHistory.dart';

import '../homePage.dart';
import '../newSession.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            // <-- SEE HERE
            decoration: BoxDecoration(color: Color(0xff1e5eff)),
            accountName: Text(
              "Akil Sundararajan",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              "akil.s@sastra.ac.in",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            currentAccountPicture: FlutterLogo(),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          ListTile(
            title: const Text('Create a session'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewSessionpage()),
              );
            },
          ),
          ListTile(
            title: const Text('View Sessions'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SessionHistoryPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Mark Attendance'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MarkAttendance()),
              );
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              AuthenticationHelper().signOut().then((value) {
                print(value);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false,
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
