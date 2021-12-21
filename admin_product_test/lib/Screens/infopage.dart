import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebutler/Model/user.dart';
import 'package:ebutler/Services/auth.dart';
import 'package:ebutler/Shared/appdrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key key}) : super(key: key);

  static const routeName = '/Infopage';
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();
    return Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text('Information'),
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () async {
                await _auth.signOut();
              },
              label: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        floatingActionButton: null,
        body: StreamBuilder(
          stream: Firestore.instance
              .collection('Information')
              .orderBy(FieldPath.documentId)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data.documents.map((document) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var i in document.data.values)
                      Text(
                        i['title'] + '\n' + i['description'],
                      ),
                  ],
                );
              }).toList(),
            );
          },
        ));
  }
}
