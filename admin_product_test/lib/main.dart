import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebutler/Model/user.dart';
import 'package:ebutler/Screens/wrapper.dart';
import 'package:ebutler/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      initialData: null,
      value: AuthService().user,
      child: MultiProvider(
        providers: [
          // ChangeNotifierProvider(
          //   create: (ctx) => Products(),
          // ),
          ChangeNotifierProvider(
            create: (ctx) => ProductsItem(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.white,
            fontFamily: 'Lato',
          ),
          home: const Wrapper(),
        ),
      ),
    );
  }
}