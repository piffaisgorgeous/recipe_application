import 'package:flutter/material.dart';

//HOME == UPLOAD DART
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // String hintValue = '';
  // String _dropDownButtonValue = 'We Are Connected';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Publish Recipe'),
          backgroundColor: Colors.grey,
        ),
        body: new SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.black,
                child: Text('PICTURE AND VIDEO'),
              ),
              SizedBox(
                height: 15,
              ),
              Container()
            ],
            // ),
          ),
        ));
  }
}
