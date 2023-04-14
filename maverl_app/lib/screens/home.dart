import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maverl_app/screens/search.dart';
import '../podo/Hero.dart';
import '../utile/constant.dart';
import 'package:crypto/crypto.dart';

import '../widget/hero_detail.dart';
import 'Setting.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List HeroList;
  late bool _loading;

  getHeroes() async {
    setState(() {
      _loading = true;
    });
    String publicKey = 'b02901689df5ddca914b5fc1f2fd91cf';
    String privateKey = '899b2a7fa046c67897987b3da4acc7347ad39834';
    String apiUrl = 'https://gateway.marvel.com/v1/public/characters';
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    final hash = md5.convert(utf8.encode('$timestamp$privateKey$publicKey')).toString();
    var url = '$apiUrl?apikey=$publicKey&ts=$timestamp&hash=$hash';
    var res = await http.get(Uri.parse(url));
    List decodedJson = jsonDecode(res.body);

    int code = res.statusCode;
    if (code == 200) {
      setState(() {
        HeroList = decodedJson;
        _loading = false;
      });
    } else {
      print("Something went wrong");
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getHeroes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/ic_launcher-web.png',height: 200,
  width: 400,),
        title: Text(
          "HeroList",
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
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
            icon: Icon(Icons.settings),
            onPressed: () {
              var router =
                  MaterialPageRoute(builder: (BuildContext context) {
                return const Settings();
              });

              Navigator.of(context).push(router);
            },
            tooltip: "Search",
          ),
        ],
      ),
      body: _loading ? _buildProgressIndicator() : _buildList(),
    );
  }

  _buildProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        valueColor:
            AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
      ),
    );
  }

  _buildList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        itemCount: HeroList.length,
        itemBuilder: (BuildContext context, int index) {
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