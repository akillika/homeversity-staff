import 'package:flutter/material.dart';

final Map<int, Color> color = {
  50: Color.fromRGBO(30, 94, 255, .1),
  100: Color.fromRGBO(30, 94, 255, .2),
  200: Color.fromRGBO(30, 94, 255, .3),
  300: Color.fromRGBO(30, 94, 255, .4),
  400: Color.fromRGBO(30, 94, 255, .5),
  500: Color.fromRGBO(30, 94, 255, .6),
  600: Color.fromRGBO(30, 94, 255, .7),
  700: Color.fromRGBO(30, 94, 255, .8),
  800: Color.fromRGBO(30, 94, 255, .9),
  900: Color.fromRGBO(30, 94, 255, 1),
};
final MaterialColor customColor = MaterialColor(0xff1e5eff, color);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MaterialColor customColor = MaterialColor(0xff1e5eff, color);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: customColor,
        primaryColor: const Color.fromARGB(255, 30, 94, 255),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homeversity Staff Login'),
      ),
    );
  }
}
