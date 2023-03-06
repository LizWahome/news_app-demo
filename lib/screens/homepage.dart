import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:news_app/data/utils/urls.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/news_data.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final List<NewsData> _news = <NewsData>[];
  static List<NewsData> _newsInApp = <NewsData>[];

  Future<List<NewsData>> comingNewsData() async {
    var url = createUrl;
    var response = await http.get(Uri.parse(url));
    var news = <NewsData>[];

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        news.add(NewsData.fromJson(noteJson));
      }
    }
    return news;
  }

  @override
  void initState() {
    comingNewsData().then((value) {
      setState(() {
        _news.addAll(value);
        _newsInApp = _news;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 249, 249),
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        title: const Text(
          "News",
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
          itemCount: _newsInApp.length,
          itemBuilder: (context, index) {
            return _listItem(index);
          }),
    );
  }

  _listItem(index) {
    return Container(
      margin: const EdgeInsets.only(top: 8, right: 16, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                _newsInApp[index].title!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
              )),
              Container(
                height: 50,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                    iconSize: 16,
                    color: Colors.black26,
                    alignment: Alignment.bottomCenter,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MaterialApp(
                                    debugShowCheckedModeBanner: false,
                                    home: Scaffold(
                                      appBar: AppBar(
                                        leading: IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(
                                              Icons.arrow_back_ios_new_rounded,
                                              color: Colors.black,
                                            )),
                                        backgroundColor: Colors.white,
                                        toolbarHeight: 100,
                                        title: Text(
                                          _newsInApp[index].title!,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 17),
                                        ),
                                      ),
                                      body: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 400,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      _newsInApp[index].image!,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                            20.height,
                                            Container(
                                                margin:
                                                    const EdgeInsets.all(16),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _newsInApp[index].title!,
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.black),
                                                    ),
                                                    15.height,
                                                    Text(_newsInApp[index]
                                                        .publisher!),
                                                    15.height,
                                                    Text(
                                                      _newsInApp[index].text!,
                                                      textScaleFactor: 1.3,
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    15.height,
                                                    Text(
                                                        "Author: ${_newsInApp[index].author!}"),
                                                    15.height,
                                                    Text(
                                                        "Date: ${_newsInApp[index].date!}"),
                                                    15.height,
                                                    const Text(
                                                        "Full story at:"),
                                                    15.height,
                                                    InkWell(
                                                      onTap: () async {
                                                        if (await launchUrl(
                                                            Uri.parse(
                                                                _newsInApp[
                                                                        index]
                                                                    .url!))) {
                                                          throw "Could not launch";
                                                        }
                                                      },
                                                      child: Text(
                                                          _newsInApp[index]
                                                              .url!,
                                                              style: const TextStyle(
                                                                color: Colors.blue
                                                              ),),
                                                    ),
                                                    // Link(
                                                    //     uri: Uri.parse(
                                                    //         _newsInApp[index]
                                                    //             .url!),
                                                    //     builder: (context,
                                                    //         followLink) {
                                                    //       return InkWell(
                                                    //         onTap: followLink,
                                                    //         child: Text(
                                                    //             _newsInApp[index]
                                                    //                 .url!,
                                                    //                 style: TextStyle(color: Colors.blue),),
                                                    //       );
                                                    //     })
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  )));
                    },
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ),
              )
            ],
          ),
          15.height,
          Text(_newsInApp[index].publisher!),
          const Divider()
        ],
      ),
    );
  }
}
