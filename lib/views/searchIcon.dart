import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recipe_application/widget/widget.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    TextEditingController search_cat = new TextEditingController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[400],
          title: Text("Search Category"),
        ),
        backgroundColor: Colors.grey[50],
        body: SingleChildScrollView(
            child: Column(children: [
          Row(
            children: [
              Container(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                      controller: search_cat,
                      decoration: textFieldInputDecoration("Search Category")),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // initiateSearch();
                },
                child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Colors.transparent,
                      Colors.transparent,
                    ])),
                    child: Icon(
                      Icons.search,
                      size: 40,
                    )),
              ),
            ],
          ),
        ])));
  }
}
