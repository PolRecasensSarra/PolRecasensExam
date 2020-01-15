import 'package:flutter/material.dart';
import 'FirstPage.dart';

void main() => runApp(FirebaseApp());

class FirebaseApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase App',
      home: FirstPage(),
    );
  }
}
