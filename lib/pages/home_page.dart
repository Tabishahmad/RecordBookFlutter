
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    int days = 30;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catelog"),
      ),
      body: Center(
        child: Container(
          child: Text("Welcome to $days days of flutter"),
        ),
      ),
      drawer: Drawer(),
    );
  }
}