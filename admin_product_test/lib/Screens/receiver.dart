import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebutler/Shared/appdrawer.dart';
import 'package:flutter/material.dart';

class Receiver extends StatelessWidget {
  const Receiver({Key key}) : super(key: key);
  static const routeName = '/receiver';

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text('Receiver'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('Products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data.documents.map((doc) {
              return Column(
                children: [
                  for (var i in doc.data.values)
                    Text(
                      i['id'].toString(),
                    ),
                  for (var i in doc.data.values)
                    Text(
                      i['title'].toString(),
                    ),
                  for (var i in doc.data.values)
                    Text(
                      i['description'].toString(),
                    ),
                  for (var i in doc.data.values)
                    Text(
                      i['price'].toString(),
                    ),
                  for (var i in doc.data.values)
                    Text(
                      i['imageurl'].toString(),
                    ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
