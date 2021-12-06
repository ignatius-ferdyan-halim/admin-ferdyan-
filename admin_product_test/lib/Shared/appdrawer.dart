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
        ],
      ),
    );
  }
}
