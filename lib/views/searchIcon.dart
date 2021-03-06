import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recipe_application/views/displaySearch.dart';
import 'package:recipe_application/widget/widget.dart';

// SEARCH == account

String sampleChoice;
List<String> choice = [''];

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
      backgroundColor: Colors.indigo[100],
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
                            textFieldInputDecoration("Search Recipe Name")),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //initiateSearch();
                    if (search_cat.text == null || search_cat.text == "") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DisplaySearch(category: choice)));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DisplaySearchRecipe(
                                  recipeName: search_cat.text)));
                    }
                   // search_cat.text = "";
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
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
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
              title: 'Sauces',
            ),
            MiCard(
              icon: Icons.local_drink_sharp,
              title: 'Beverage',
            ),
            MiCard(
              icon: Icons.dinner_dining,
              title: 'Breakfast Food',
            ),
            MiCard(
              icon: Icons.set_meal,
              title: 'Lunch Cuisine',
            ),
            MiCard(
              icon: Icons.dining,
              title: 'Dinner Style',
            ),
            MiCard(
              icon: Icons.fastfood,
              title: 'Sandwiches',
            ),
            MiCard(
              icon: Icons.food_bank,
              title: 'Finger Food',
            ),
            MiCard(
              icon: Icons.dinner_dining,
              title: 'Vegetarian Cuisine',
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

int i = 0;

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
                width: 17,
              ),
              Text(
                widget.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Checkbox(
            checkColor: Colors.white,
            activeColor: Colors.indigo,
            value: this.valuefirst,
            onChanged: (bool value) {
              setState(() {
                sampleChoice = widget.title.toLowerCase();
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
