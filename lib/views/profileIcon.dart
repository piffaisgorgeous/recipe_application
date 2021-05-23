// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:recipe_application/services/database.dart';

// class Profile extends StatefulWidget {
//    final String userName; 
//   final String userEmail;
//  Profile({this.userName, this.userEmail});
//   @override
//   _ProfileState createState() => _ProfileState();
// }

// // ACCOUNT == HOME
// class _ProfileState extends State<Profile> {

//   DatabaseMethods databaseMethods = new DatabaseMethods();
//    Stream getUser;
//      Stream getEmail;


//   Widget Username() {
//     return StreamBuilder(
//         stream:  getUser,
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           return snapshot.hasData
//               ? ListView.builder(
//                   itemCount: snapshot.data.docs[0].data()['user_name'].length,
//                   itemBuilder: (context, index) {
//                     return Text(snapshot.data.docs[0].data()['user_name'].toString());
//                   },
//                 )
//               : Container();
//         });
//   }

//   getPublish(){
//      databaseMethods.getUserPublish(widget.userEmail).then((result) {
//         log("as");
//       setState(() {
//         log("fg");
//        getEmail = result;
//       });
//     });
//   }


// @override
//   void initState() {
//     //off ko sa call na palong ako phone
//     //  databaseMethods.getUserbyUsername(widget.userName).then((result) {
//     //     log("sdfs");
//     //   setState(() {
//     //     log("sdfs");
//     //    getUser = result;
//     //   });
//     // });
//      getPublish();
//      databaseMethods.getUserbyUserEmail(widget.userEmail).then((result) {
//       setState(() {
//        getEmail = result;
//       });
//     });
//     super.initState();
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.indigo[100],
//         appBar: AppBar(
//             centerTitle: true,
//             title: Text('Account'),
//             backgroundColor: Colors.indigoAccent[100]),
//         body: 
//         Container(
//           child: SafeArea(
//               child: new SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.only(left: 150, right: 150, top: 50),
//                   child: Column(
//                     children: [
//                      Username()
                     
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Text(
//                       "35",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     // SizedBox(
//                     //   width: 20,
//                     // ),
//                     Text(
//                       "0",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     // SizedBox(
//                     //   width: 20,
//                     // ),
//                     Text(
//                       "1M",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     )
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Text(
//                       "Publications",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     // SizedBox(
//                     //   width: 20,
//                     // ),
//                     Text(
//                       "Following",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     // SizedBox(
//                     //   width: 20,
//                     // ),
//                     Text(
//                       "Followers",
//                       style: TextStyle(fontSize: 16),
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 // FAVOURITES
//                 Padding(
//                   padding: const EdgeInsets.only(right: 260),
//                   child: Column(
//                     // ROW
//                     children: [
//                       Text(
//                         "Favourites",
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 // KATONG PINA SWIPE2 BITAW KATONG PINA KAROSEL ARI NGA PART
//                 // NAA ANG MGA PICTURES AND SHITS
//                 Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 15),
//                       child: Container(
//                         height: 200,
//                         child: Text(
//                             'PART 2 FAVE'), // FAVE TAHAY NIYA NGA RECIPE NGANHI BOSHET
//                         color: Colors.green,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10),
//                       child: Container(
//                         height: 200,
//                         child: Text('ARI TAHAY IYANG FAVEY'),
//                         color: Colors.green,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10),
//                       child: Container(
//                         height: 200,
//                         child: Text('HATDOG AGAIN'),
//                         color: Colors.green,
//                       ),
//                     ),
//                   ],
//                 ),
//                 // ARI ANG PUBLICATIONS
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20),
//                   child: Row(
//                     children: [
//                       Text(
//                         "Publications",
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 // KATONG PINA SWIPE2 BITAW
//                 Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 15),
//                       child: Container(
//                         height: 300,
//                         child: Text('PART 2 FAVE'),
//                         color: Colors.green,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10),
//                       child: Container(
//                         height: 200,
//                         child: Text('ARI TAHAY IYANG FAVEY'),
//                         color: Colors.green,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10),
//                       child: Container(
//                         height: 200,
//                         child: Text('HATDOG AGAIN'),
//                         color: Colors.green,
//                       ),
//                     ),
//                   ],
//                 ),

//                 SizedBox(
//                   height: 15,
//                 ),
//               ],
//             ),
//           )),
//         ));

//   }
// }
