import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app/controller/main_provider.dart';
import 'package:quotes_app/models/db_helper.dart';
import 'package:quotes_app/models/quotes_model.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MainProvider>(context, listen: false).getLikedqoute =
        DbHelper.dbHelper.selectlikedq();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: Text("Liked Quotes"),
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.network(
                "https://e1.pxfuel.com/desktop-wallpaper/123/781/desktop-wallpaper-dark-clouds-aesthetic-clouds-dark.jpg",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Consumer<MainProvider>(
              builder:
                  (BuildContext context, MainProvider value, Widget? child) =>
                      FutureBuilder(
                future: value.getLikedqoute,
                builder: (context, snapshot) {
                  List<QuotesModel>? data = snapshot.data;
                  if (data != null) {
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(25)),
                            child: ListTile(
                              tileColor: Colors.black26,
                              title: Text(
                                "${data[index].q}",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              trailing: InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Delete ?"),
                                          content: Text(
                                              "Are you sure want to delete ?"),
                                          actions: [
                                            InkWell(
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Cancle")),
                                            InkWell(
                                                onTap: () async {
                                                  print(index);
                                                  int? id = await DbHelper
                                                      .dbHelper
                                                      .deleteQuote(
                                                          id: index + 1);
                                                  if (id == 1) {
                                                    Provider.of<MainProvider>(
                                                                context,
                                                                listen: false)
                                                            .getLikedqoute =
                                                        DbHelper.dbHelper
                                                            .selectlikedq();
                                                  }
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Delete")),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Icon(Icons.delete)),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text("no liked Quotes"));
                  }
                },
              ),
            ),
          ],
        ));
  }
}
