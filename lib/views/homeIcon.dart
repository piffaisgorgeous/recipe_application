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
        appBar: AppBar(
          centerTitle: true,
          title: Text('Recipes'),
          backgroundColor: Colors.indigo[400],
        ),
        body: SafeArea(
            child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [
                Colors.indigoAccent[100],
                Colors.indigo,
              ])),
        ))
        // new SingleChildScrollView(
        //   child: Column(
        //     children: <Widget>[
        //       Container(
        //         // color: Colors.black,
        //         // child: Text('PICTURE AND VIDEO'),
        //       ),
        //       SizedBox(
        //         height: 15,
        //       ),
        //       Container()
        //     ],
        //     // ),
        //   ),
        // )
        );
  }
}
