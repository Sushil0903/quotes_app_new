import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:quotes_app/models/quotes_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // QuotesModel? model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Text("Quots App"),
          centerTitle: true,
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
            FutureBuilder(
              future: get(Uri.parse("https://zenquotes.io/api/quotes")),
              builder: (context, snapshot) {
                Response? res = snapshot.data;
                if (res != null) {
                  List<QuotesModel> model = quotesModelFromJson(res.body);
                  return ListView.builder(
                    itemCount: model.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 15, right: 15),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "detail",
                                arguments: index);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white30,
                                borderRadius: BorderRadius.circular(18)),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  model[index].q ?? "",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "~ ${model[index].a ?? " "}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      size: 28,
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Icon(
                                      Icons.share,
                                      size: 28,
                                      color: Colors.black54,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );

                  return Text(res.body);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ));
  }
}
