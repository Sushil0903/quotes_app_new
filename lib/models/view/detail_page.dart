import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app/controller/main_provider.dart';
import 'package:quotes_app/models/quotes_model.dart';
import 'package:share_extend/share_extend.dart';

import '../db_helper.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    List<QuotesModel> data = Provider.of<MainProvider>(context).DModel;
    var id = ModalRoute.of(context)?.settings.arguments as int;
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
              child: Container(
            height: 300,
            width: 220,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${data[id].q}",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "~ ${data[id].a}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 300,
              height: 80,
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {
                      var insertint = await DbHelper.dbHelper.InsertlikedQuotes(
                          q: data[id].q ?? "empty q",
                          a: data[id].q ?? "empty a");
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Add to Liked list")));
                    },
                    child: Icon(
                      Icons.favorite_border,
                      size: 40,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      ShareExtend.share("${data[id].q}", "text",
                          sharePanelTitle: "Quote");
                    },
                    child: Icon(
                      Icons.share,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
