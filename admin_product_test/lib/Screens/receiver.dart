import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ebutler/Shared/appdrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Receiver extends StatelessWidget {
  const Receiver({Key key}) : super(key: key);
  static const routeName = '/receiver';

  @override
  Widget build(BuildContext context) {
    String newTotal;
    Timestamp newTime;
    DateTime newDate;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text('Receiver'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('Cart').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data.documents.map((doc) {
              newTotal = '';
              newDate = null;

              for (var i in doc.data.values) {
                newTotal = i['Total Price'].toString();
                break;
              }
              for (var i in doc.data.values) {
                newTime = i['Time'];
                newDate = newTime.toDate();
                break;
              }

              return Column(
                children: [
                  for (var i in doc.data.values)
                    Text(
                      i['Item Id'].toString(),
                    ),
                  for (var i in doc.data.values)
                    Text(
                      i['Title'].toString(),
                    ),
                  for (var i in doc.data.values)
                    Text(
                      i['Price'].toString(),
                    ),
                  for (var i in doc.data.values)
                    Text(
                      i['Quantity'].toString(),
                    ),
                  for (var i in doc.data.values)
                    Text(
                      (i['Total'].toString()),
                    ),
                  newTotal == null ? Text('') : Text(newTotal),
                  newDate == null ? Text('') : Text(newDate.toString()),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
