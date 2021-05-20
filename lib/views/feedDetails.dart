import 'package:flutter/material.dart';
import 'package:recipe_application/widget/widget.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart';

class FeedDetail extends StatefulWidget {
  final String name;
  final String image;
  final String foodName;
  FeedDetail({this.name, this.image, this.foodName});
  @override
  _FeedDetailState createState() => _FeedDetailState();
}

class _FeedDetailState extends State<FeedDetail> {
  int choice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
            backgroundColor: Colors.indigo[400],
            title: Text(
              'Feed Details',
              style: TextStyle(color: Colors.white),
            )),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              chuchu(),
            ],
          ),
        ));
  }

  Widget chuchu() {
    if (widget.name == "enfagrow" && widget.foodName == "gatas") {
      return GestureDetector(
        onTap: _showDialog,
        child: cardFeedDetails(
            context, widget.foodName, widget.name, widget.image),
      );
    }
  }

  void _showDialog() {
    showSlideDialog(
      barrierDismissible: true,
      context: context,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: () {
                    choice = 1;
                    // setState(() {});
                  },
                  child: Text(
                    "Ingredients",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
              GestureDetector(
                  onTap: () {
                    choice = 2;
                    // setState(() {});
                  },
                  child: Text(
                    "Recipe",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                child: choice == 1
                    ? Container(
                        color: Colors.orange,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.timelapse),
                                Text("30 mins")
                              ],
                            ),
                            rowFeedHealth(1, 2, 3, 4),
                            rowFeed("chuchu", "23"),
                            rowFeed("chucha", "23"),
                            rowFeed("chuche", "23"),
                          ],
                        ))
                    : Container(
                        color: Colors.green,
                        child: Column(
                          children: [
                            rowFeed("asd", "23"),
                            rowFeed("asd", "23"),
                            rowFeed("asd", "23"),
                            rowFeed("asd", "23"),
                          ],
                        ))),
          ),
        ],
      ),
      barrierColor: Colors.white.withOpacity(0.7),
      pillColor: Colors.red,
      backgroundColor: Colors.yellow,
    );
  }
}
