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
          // return ListView(
          //   children: snapshot.data.documents.map((document) {
          //     return Center(
          //       child: Container(
          //         width: MediaQuery.of(context).size.width / 1.2,
          //         height: MediaQuery.of(context).size.width / 6,
          //         child: Text(document['index']),
          //       ),
          //     );
          //   }).toList(),
          // );
          return ListView(
            children: snapshot.data.documents.map((doc) {
              return Column(
                // children: List.generate(
                //   List.from(doc['Products']).length,
                //   (index) {
                //     return Row(
                //       children: [Text(doc['Products'][index]['title'])],
                //     );
                //   },
                // ),
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
                // children: [
                //   for (var i in doc.data.values)
                //     Text(
                //       i['id'].toString(),
                //     ),
                //   for (var i in doc.data.values)
                //     Text(
                //       i['title'].toString(),
                //     ),
                //   for (var i in doc.data.values)
                //     Text(
                //       i['description'].toString(),
                //     ),
                //   for (var i in doc.data.values)
                //     Text(
                //       i['price'].toString(),
                //     ),
                //   for (var i in doc.data.values)
                //     Text(
                //       i['imageurl'].toString(),
                //     ),
                // ],
                // child: Text(doc.data['0']['title']),
              );
              // ListView(
//     children: List.generate(
//       List.from(doc['orderDetails'].length,
//       (i) {
//        return Row(
//         children: [
//           Text(doc['orderDetails'][i]['quantity'].toString()),
//           Text(doc['orderDetails'][i]['title'].toString())),
//         ],
//       );
//     )
// )
            }).toList(),
          );
        },
      ),
    );
  }
}
