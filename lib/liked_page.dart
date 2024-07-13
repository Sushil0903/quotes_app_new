import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/home_controller.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  HomeController Controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: FutureBuilder(
          future: Controller.SelectQuotes(),
          builder: (context, snapshot) {
            var res = snapshot.data;
            if (res != null) {
              var res = snapshot.data;
            } else {
              return Text("no liked list");
            }
          },
        ));
  }
}
