// ignore_for_file: library_private_types_in_public_api
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../podo/Hero.dart';

class DetailPage extends StatelessWidget {
  final Heros hero;
  DetailPage({Key? key, required this.hero}): super(key:key);

  @override
  Widget build(BuildContext context) {
    Widget descriptionSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        hero.description,
        softWrap: true,
      ),
    );

    Widget titleSection = Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(hero.name,
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                  ],
                )),
          ],
        ));

    return Scaffold(
          appBar: AppBar(
            title: Text("Marvel"),
          ),
          body: ListView(
              children: [
                Container(
                  width: 600,
                  height: 240,
                  child : Image.network(hero.thumbnailUrl)

                ),
                titleSection,
                descriptionSection
              ]));
  }
}