// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maverl_app/screens/search.dart';
import '../podo/Hero.dart';
import 'package:crypto/crypto.dart';

import '../widget/hero_detail.dart';
import 'Setting.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List HeroList = [];
  int page = 0;
  bool _loading = true;
  bool load = false;
  ScrollController scrollController = ScrollController();

  getHeroes(pages) async {
    setState(() {
      load = true;
    });
    var offset = (pages * 20);
    String publicKey = 'b02901689df5ddca914b5fc1f2fd91cf';
    String privateKey = '899b2a7fa046c67897987b3da4acc7347ad39834';
    String apiUrl = 'gateway.marvel.com';
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    final hash =
        md5.convert(utf8.encode('$timestamp$privateKey$publicKey')).toString();

    Map<String, dynamic> queryParameters = {
      "apikey": publicKey,
      "hash": hash,
      "ts": timestamp,
      "limit": "20",
      "offset": offset.toString()
    };
    final uri = Uri.https(apiUrl, '/v1/public/characters', queryParameters);
    var res = await http.get(uri);
    final decodedJson = jsonDecode(res.body);
    final List<dynamic> characterData = decodedJson['data']['results'];
    int code = res.statusCode;
    HeroList.addAll(characterData);
    int p = page + 1;
    if (code == 200) {
      setState(() {
        HeroList;
        _loading = false;
        load = false;
        page = p;
      });
    } else {
      print("Something went wrong");
      setState(() {
        _loading = false;
      });
    }
  }

  void handleNext() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        load = true;
        getHeroes(page);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getHeroes(page);
    handleNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "HeroList",
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            // ignore: unnecessary_null_comparison
            onPressed: HeroList == null
                ? null
                : () {
                    showSearch(
                      context: context,
                      delegate: Search(all: HeroList),
                    );
                  },
            tooltip: "Search",
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              var router = MaterialPageRoute(builder: (BuildContext context) {
                return const Settings();
              });

              Navigator.of(context).push(router);
            },
            tooltip: "Search",
          ),
        ],
      ),
      body: _buildList(),
    );
  }

  _buildProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.secondary),
      ),
    );
  }

  _buildList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        controller: scrollController,
        itemCount: HeroList.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == HeroList.length) {
            return load
                ? Container(
                    height: 200,
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                      ),
                    ),
                  )
                : Container();
          }
          Heros heroItem = Heros.fromJson(HeroList[index]);
          return Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: SuperHero(
              hero: heroItem,
            ),
          );
        },
      ),
    );
  }
}
