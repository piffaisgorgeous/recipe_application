import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recipe_application/views/displaySearch.dart';
import 'package:recipe_application/widget/widget.dart';

// SEARCH == account
String sampleChoice;
List<String> choice = [];
class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    TextEditingController search_cat = new TextEditingController();
    choice.clear();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[400],
        title: Text("Search Category"),
      ),
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 350,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                        controller: search_cat,
                        decoration:
                            textFieldInputDecoration("Search Category")),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                     //initiateSearch();
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DisplaySearch(category:choice)
                                ));
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
            SizedBox(
              height: 10,
            ),
            Text(
              'Categories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            MiCard(
              icon: Icons.donut_small,
              title: 'Pastries and desserts',
            ),
            MiCard(
              icon: Icons.food_bank,
              title: 'Main dishes',
            ),
            MiCard(
              icon: Icons.food_bank_outlined,
              title: 'Salad',
            ),
            MiCard(
              icon: Icons.emoji_food_beverage,
              title: 'Bouillons',
            ),
            MiCard(
              icon: Icons.fastfood,
              title: 'Snacks',
            ),
            MiCard(
              icon: Icons.emoji_food_beverage_sharp,
              title: 'Ginamos',
            ),
            MiCard(
              icon: Icons.local_drink_sharp,
              title: 'Beverage',
            ),
            MiCard(
              icon: Icons.dinner_dining,
              title: 'Dine In',
            ),
            MiCard(
              icon: Icons.set_meal,
              title: 'Fish',
            ),
            MiCard(
              icon: Icons.favorite_outline_sharp,
              title: 'Fruits',
            ),
          ],
        ),
      ),
    );
  }
}

class MiCard extends StatefulWidget {
  final IconData icon;
  final String title;

  const MiCard({Key key, this.icon, this.title}) : super(key: key);

  @override
  _MiCardState createState() => _MiCardState();
}



  int i=0;
class _MiCardState extends State<MiCard> {
  // Map<String, dynamic> iconMap = {"icon": widget.icon};
  bool valuefirst = false;
  bool valuesecond = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(widget.icon),
              SizedBox(
                width: 10,
              ),
              Text(widget.title)
            ],
          ),
        ),
        Checkbox(
            checkColor: Colors.amber,
            activeColor: Colors.red,
            value: this.valuefirst,
            onChanged: (bool value) {
              setState(() {
                sampleChoice=widget.title.toLowerCase();
                this.valuefirst = value;
                choice.add(widget.title.toLowerCase());
              });
            
                log(choice[i]);
                i++;
            }),

          
      ],
    );
  }
}
