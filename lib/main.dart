import 'package:asha/screens/auth_screen.dart';
//import 'package:asha/screens/login.dart';
import 'package:flutter/material.dart';

void main()=>runApp(AshaMain());

class AshaMain extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthScreen(),);
  }
}
