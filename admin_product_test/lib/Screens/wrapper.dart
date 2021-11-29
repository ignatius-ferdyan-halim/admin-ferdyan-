import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebutler/Screens/receiver.dart';
import 'package:ebutler/Services/database.dart';
import 'package:ebutler/providers/productdb.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/Model/user.dart';
import '/Screens/Authenticate/authenticate.dart';
import '/Screens/products.dart';
import '/providers/products.dart' as prod;

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return const Authenticate();
    } else {
      return
          // StreamProvider<List<prod.Products>>.value(
          //   child: Products(),
          //   value: DatabaseService().productsStream,
          //   initialData: [],
          // );
          //tadinya
          StreamProvider<QuerySnapshot>.value(
        child: Receiver(),
        value: DatabaseService().productSnapshot,
        initialData: null,
      );
    }
  }
}
