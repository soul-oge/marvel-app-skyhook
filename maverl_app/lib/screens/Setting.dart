// ignore: file_names
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Error'), centerTitle: true),
        body: const Center(
          child: Text('Page not found'),
        ));
  }
}
