import 'package:flutter/material.dart';
import 'package:quotes_app/detail_page.dart';
import 'package:quotes_app/home_page.dart';
import 'package:quotes_app/liked_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(),
        "detail": (context) => DetailPage(),
        "liked_page": (context) => LikedPage(),
      },
    );
  }
}
