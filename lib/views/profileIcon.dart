import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

// ACCOUNT == HOME
class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo[100],
        appBar: AppBar(
            centerTitle: true,
            title: Text('Account'),
            backgroundColor: Colors.indigoAccent[100]),
        body: Container(
          child: SafeArea(
              child: new SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 150, right: 150, top: 50),
                  child: Column(
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "35",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // SizedBox(
                    //   width: 20,
                    // ),
                    Text(
                      "0",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // SizedBox(
                    //   width: 20,
                    // ),
                    Text(
                      "1M",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Publications",
                      style: TextStyle(fontSize: 16),
                    ),
                    // SizedBox(
                    //   width: 20,
                    // ),
                    Text(
                      "Following",
                      style: TextStyle(fontSize: 16),
                    ),
                    // SizedBox(
                    //   width: 20,
                    // ),
                    Text(
                      "Followers",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                // FAVOURITES
                Padding(
                  padding: const EdgeInsets.only(right: 260),
                  child: Column(
                    // ROW
                    children: [
                      Text(
                        "Favourites",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                // KATONG PINA SWIPE2 BITAW KATONG PINA KAROSEL ARI NGA PART
                // NAA ANG MGA PICTURES AND SHITS
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Container(
                        height: 200,
                        child: Text(
                            'PART 2 FAVE'), // FAVE TAHAY NIYA NGA RECIPE NGANHI BOSHET
                        color: Colors.green,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        height: 200,
                        child: Text('ARI TAHAY IYANG FAVEY'),
                        color: Colors.green,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        height: 200,
                        child: Text('HATDOG AGAIN'),
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                // ARI ANG PUBLICATIONS
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        "Publications",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                // KATONG PINA SWIPE2 BITAW
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Container(
                        height: 300,
                        child: Text('PART 2 FAVE'),
                        color: Colors.green,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        height: 200,
                        child: Text('ARI TAHAY IYANG FAVEY'),
                        color: Colors.green,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        height: 200,
                        child: Text('HATDOG AGAIN'),
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 15,
                ),
              ],
            ),
          )),
        ));

    // return SafeArea(
    //     child: Scaffold(
    //   appBar: AppBar(
    //     centerTitle: true,
    //     title: Text('Profile'),
    //     backgroundColor: Colors.indigo[400],
    //   ),
    //   body: Container(
    //       child: Padding(
    //     padding: const EdgeInsets.only(left: 180, right: 180, top: 50),
    //     child: Text(
    //       "Name",
    //       style: TextStyle(fontSize: 15),
    //     ),

    //   ),

    //   ),

    // ));

    // Widget build(BuildContext context) {
    //   return Scaffold(
    //     appBar: AppBar(
    //       centerTitle: true,
    //       title: Text('Profile'),
    //       backgroundColor: Colors.indigo[400],
    //     ),
    //     body: Container(
    //       decoration: BoxDecoration(
    //         gradient: LinearGradient(
    //             begin: Alignment.topRight,
    //             end: Alignment.bottomRight,
    //             colors: [
    //               Colors.indigoAccent[100],
    //               Colors.indigo,
    //             ]),
    //       ),
    //       child: Text("Name"),
    //     ),

    // SafeArea(
    //     child: Container(
    //   decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //         begin: Alignment.topRight,
    //         end: Alignment.bottomRight,
    //         colors: [
    //           Colors.indigoAccent[100],
    //           Colors.indigo,
    //         ]),
    //   ),
    //   // child: Text("Name")
    // ),

    // )
  }
}
