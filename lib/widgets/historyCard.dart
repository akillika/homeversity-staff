// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SessionCard extends StatefulWidget {
  final String subName;
  final String year;
  final String section;
  final String timeStamp;
  const SessionCard(
      {Key? key,
      required this.subName,
      required this.year,
      required this.section,
      required this.timeStamp})
      : super(key: key);

  @override
  State<SessionCard> createState() => _SessionCardState();
}

class _SessionCardState extends State<SessionCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
                spreadRadius: 0.0,
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.subName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xff1e5eff)),
                  ),
                  Text(
                    DateFormat("dd-MM-yyyy")
                        .format(DateTime.parse(widget.timeStamp))
                        .toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                ],
              ),
              Text(
                "${widget.year} - ${widget.section}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
