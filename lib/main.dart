import 'package:flutter/material.dart';
import 'list_of_users.dart';
import 'user.dart';
import 'Authorization.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => AuthPage(),
          '/ reg': (context) => const Registration(),
          '/ list': (context) => const ListOfUsers(),
          '/ user': (context) => InfoUser(),
        });
  }
}