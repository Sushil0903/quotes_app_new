import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app/controller/main_provider.dart';
import 'package:quotes_app/models/view/detail_page.dart';
import 'package:quotes_app/models/view/home_page.dart';
import 'package:quotes_app/models/view/liked_page.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
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
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => MainProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => HomePage(),
          "detail": (context) => DetailPage(),
          "liked_page": (context) => LikedPage(),
        },
      ),
    );
  }
}
