import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../podo/Hero.dart';
import '../widget/hero_detail.dart';

class Search extends SearchDelegate {
  final List all;

  Search({required this.all});

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    String query1;
    var query2 = " ";
    if (query.length != 0) {
      query1 = query.toLowerCase();
      query2 = query1[0].toUpperCase() + query1.substring(1);
    }

    //Search in the json for the query entered
    var search = all.where((hero) => hero['name'].contains(query2)).toList();

    // ignore: unnecessary_null_comparison
    return search == null
        ? _buildProgressIndicator()
        : _buildSearchList(search);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    String query1;
    var query2 = "";
    if (query.isNotEmpty) {
      query1 = query.toLowerCase();
      query2 = query1[0].toUpperCase() + query1.substring(1);
    }

    List search;

    if (query2.isNotEmpty) {
      search = all.where((hero) => hero['name'].contains(query2)).toList();
    } else {
      search = all;
    }

    // ignore: unnecessary_null_comparison
    return search == null
        ? _buildProgressIndicator()
        : _buildSearchList(search);
  }

  _buildSearchList(List search) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: search == null ? 0 : search.length,
        itemBuilder: (BuildContext context, int position) {
          Heros heroItem = Heros.fromJson(search[position]);

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

  _buildProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
      ),
    );
  }
}
