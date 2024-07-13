import 'package:flutter/material.dart';
import 'package:quotes_app/models/db_helper.dart';
import 'package:quotes_app/models/quotes_model.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  @override
  late Future<List<QuotesModel>> getQuotes;
  void initState() {
    // TODO: implement initState
    getQuotes = DbHelper.dbHelper.selectlikedq();
    super.initState();
  }

  List<QuotesModel>? data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: Text(
            "Liked Quotes",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: FutureBuilder(
          future: getQuotes,
          builder: (context, snapshot) {
            data = snapshot.data;
            if (data != null) {
              return ListView.builder(
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  print(data?[index].q);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      tileColor: Colors.black26,
                      title: Text(
                        "${data?[index].q}",
                        style: TextStyle(fontSize: 20),
                      ),
                      trailing: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text("Are you sure want to Delete ?"),
                                title: Text("Delete ?"),
                                actions: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancle")),
                                  InkWell(
                                      onTap: () async {
                                        int? deleteint = await DbHelper.dbHelper
                                            .deleteQuote(id: index);
                                        if (deleteint == 1) {
                                          setState(() {
                                            getQuotes = DbHelper.dbHelper
                                                .selectlikedq();
                                          });
                                        }

                                        Navigator.pop(context);
                                      },
                                      child: Text("Delete"))
                                ],
                              );
                            },
                          );
                        },
                        child: const Icon(
                          Icons.delete,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Text(
                  "Press like button to add quotes on liked list");
            }
          },
        ));
  }
}
