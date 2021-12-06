import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebutler/Model/user.dart';
import 'package:ebutler/Screens/infopage.dart';
import 'package:ebutler/Screens/informationpage.dart';
import 'package:ebutler/Screens/wrapper.dart';
import 'package:ebutler/Services/auth.dart';
import 'package:ebutler/providers/informations.dart' as info;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/receiver.dart';
import '/Screens/products.dart';
import '/providers/products.dart' as prod;

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
            create: (ctx) => prod.ProductsItem(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => info.Informationlist(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.white,
            fontFamily: 'Lato',
          ),
          home: const Wrapper(),
          routes: {
            Receiver.routeName: (ctx) => const Receiver(),
            InformationPage.routeName: (ctx) => const InformationPage(),
            InfoPage.routeName: (ctx) => const InfoPage(),
            // Products.routeName: (ctx) => const Products(),
          },
        ),
      ),
    );
  }
}
