import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/domain/service/firebase_service.dart';
import 'package:flutter_firebase/ui/screens/auth_screen.dart';
import 'package:flutter_firebase/ui/screens/user_info_screen.dart';

final GlobalKey<NavigatorState> kNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    final serviceFirebase = FirebaseService();
    serviceFirebase.onListernUser((user) {
      if (user == null) {
        Navigator.push(kNavigatorKey.currentContext!, MaterialPageRoute(builder: (_) => AuthScreen()));
      } else {
        Navigator.push(kNavigatorKey.currentContext!, MaterialPageRoute(builder: (_) => UserInfoScreen(user: user)));
      }
    });
    FirebaseAuth.instance.authStateChanges().listen((User? user) {

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: kNavigatorKey,
      theme: ThemeData(
        colorScheme:  ColorScheme.fromSwatch(
          primarySwatch:  Colors.orange,
        ),
        // brightness: Brightness.dark,
        // primaryColor:Colors.orange[400] ,
      ),
      home: AuthScreen(),
    );
  }
}
