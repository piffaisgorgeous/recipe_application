import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'helper/authenticate.dart';
import 'helper/helperfunctions.dart';
import 'package:flutter/services.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);

//   await Firebase.initializeApp();

//   runApp(MyApp());
// }


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn=false;

@override
  void initState() {
    getLoggedInState();
    super.initState();
  }

getLoggedInState()async{
  await HelperFunctions.getUserLoggedInSharedPreference().then((result){
    setState(() {
     userIsLoggedIn = result;
    });
  });
}


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PPB MESSENGER',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff145C9E),
          scaffoldBackgroundColor: Color(0xff1F1F1F),
          accentColor: Color(0xff007EF4),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
    //      home: userIsLoggedIn != null ?  userIsLoggedIn ? ChatRoom() : Authenticate()
    //       : Container(
    //     child: Center(
    //       child: Authenticate(),
    //     ),
    //   ),
    // );
    home:   Authenticate() );
     // home:   userIsLoggedIn ?ChatRoom(): Authenticate() );
  }
}


