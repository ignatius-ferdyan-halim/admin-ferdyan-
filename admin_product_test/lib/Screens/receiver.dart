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

          // void getData() {
          //   for (int i = 0; i < snapshot.data.documents.length; i++) {
          //     snapshot.data.documents.map((doc) {
          //       Text(doc.data['$i']['id']);
          //     }).toList();
          //   }
          // }

          // return ListView(
          //   children: snapshot.data.documents.map((document) {
          //     return Center(
          //       child: Container(
          //         width: MediaQuery.of(context).size.width / 1.2,
          //         height: MediaQuery.of(context).size.width / 6,
          //         child: Text(document['Time'].toString()),
          //       ),
          //     );
          //   }).toList(),
          // );
          return ListView(
            //dilistview ini itu dia uda ngeloop sesuai dari banyaknya dokumen
            //misal ada 3 dokumen gitu, ntar loop pertama dia bakal masuk ke dokumen pertama
            //abis itu di loop pertama bakal jalanin for var i yg bakal nyari data pada dokumen itu
            //di index yang sesuai
            children: snapshot.data.documents.map((doc) {
              // for (var i in doc.data.values) {
              //   compare = i['Total Price'];
              // }

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
                  //i di sini bwt nentuin data dokumen ke berapa
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

                // children: [
                //   for (var i in doc.data.values)
                //     Text(
                //       i['Title'].toString(),
                //     ),
                // ],

                // ],
                // child: Text(doc.data['0']['title']),
                // children: List.generate(
                //   List.from(doc['Products']).length,
                //   (index) {
                //     return Row(
                //       children: [Text(doc['Products'][index]['title'])],
                //     );
                //   },
                // ),
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
