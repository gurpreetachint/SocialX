import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:socialx/screens/home/news.dart';
import '../../services/auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

late Future<News> futureNews;
final AuthService _auth = AuthService();
TextEditingController _searchController = TextEditingController();
String? search;
const _apiKey = '6d7276c81a1043f18c998ce2da1a7713';

Future<News> fetchNews(String? value) async {
  final response = await http.get(Uri.parse(
      'https://newsapi.org/v2/everything?q=$value&sortBy=publishedAt&apiKey=$_apiKey'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return News.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    futureNews = fetchNews('India');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Search for News'),
        backgroundColor: const Color.fromRGBO(255, 0, 0, 1),
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            return fetchNews(_searchController.text);
          },
          child: FutureBuilder<News>(
            future: futureNews,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () => _searchController.clear(),
                            ),
                            prefixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                setState(() {
                                  futureNews =
                                      fetchNews(_searchController.text);
                                });
                              },
                            ),
                            fillColor: Colors.blue,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.totalResults,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              2 /
                                              3,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${snapshot.data!.articles![index].publishedAt} \t\t ${snapshot.data!.articles![index].author}',
                                                overflow: TextOverflow.fade,
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.grey),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  snapshot.data!
                                                      .articles![index].title
                                                      .toString(),
                                                  maxLines: 2,
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                  snapshot.data!
                                                      .articles![index].content
                                                      .toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                      fontSize: 9)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1 /
                                                5,
                                            child: Image.network(
                                              snapshot.data!.articles![index]
                                                  .urlToImage
                                                  .toString(),
                                              fit: BoxFit.cover,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
