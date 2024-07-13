import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.network(
              "https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvam9iMjk1LXBsb3ktMDFjLTA1LmpwZw.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Center(
              child: Text(
            "data ${data}",
            style: TextStyle(fontSize: 50),
          ))
        ],
      ),
    );
  }
}
