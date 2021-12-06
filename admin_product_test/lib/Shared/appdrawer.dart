import 'package:ebutler/Screens/infopage.dart';
import 'package:ebutler/Screens/informationpage.dart';
import 'package:ebutler/Screens/products.dart';
import 'package:ebutler/Screens/receiver.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Menus'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Insert Product'),
            onTap: () {
              Navigator.of(context).pushNamed(Products.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Receiver'),
            onTap: () {
              Navigator.of(context).pushNamed(Receiver.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Information'),
            onTap: () {
              Navigator.of(context).pushNamed(InformationPage.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Informationpage'),
            onTap: () {
              Navigator.of(context).pushNamed(InfoPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
