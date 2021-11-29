import 'package:cloud_firestore/cloud_firestore.dart';

import '/providers/products.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
//ini tu bwt ngisi yg uid: user.uid, jadi kalo mau pake data lain tinggal diganti
//ntar tinggal nama document nya disesuain dari yg diisi
//kayakny bs pake room number, uid ny gnti jd room number, room numbernya di sruh input sblm order now
  final products = ProductsItem();
  final CollectionReference cartCollection =
      Firestore.instance.collection('Products');

  Future setDocument() async {
    return await cartCollection.document(uid).setData({});
  }

  Future updateProductData(int index, String id, String title, int price,
      String description, String imageUrl) async {
    Map<String, Object> products = {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'imageurl': imageUrl
    };

    return await cartCollection.document(uid).updateData({
      '$index': products,
    });
  }

  List<Products> _productsSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      int count = doc.data.length;

      if (count != 0) {
        print('count: $count');
        // Product() = List.from(temp);
        for (int i = 0; i < count; i++) {
          print('i: $i');
          return Products(
            id: doc.data['$i']['id'],
            price: doc.data['$i']['price'],
            description: doc.data['$i']['description'],
            imageURL: doc.data['$i']['imageurl'],
            title: doc.data['$i']['title'],
          );

          // temp.add(Products(
          //   id: temp[0],
          //   price: temp[0],
          //   description: temp[0],
          //   imageURL: temp[0],
          //   title: temp[0],
          // ));
        }
        // return Products();
        // for (var i in doc.data.values) {
        //   print(i);
        //   return Products(
        //       id: i['id'],
        //       price: i['price'],
        //       description: i['description'],
        //       imageURL: i['imageurl'],
        //       title: i['title']);
        // }
      } else {
        return Products(
          id: 'id',
          price: 0,
          description: 'desc',
          imageURL: 'url',
          title: 'title',
        );
      }
    }).toList();
  }
  // List<Products> _productsSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.documents.map((doc) {
  //     return Products(
  //       id: doc.data['id'] ?? 'id',
  //       price: doc.data['price'] ?? 0,
  //       description: doc.data['description'] ?? 'desc',
  //       imageURL: doc.data['imageurl'] ?? 'url',
  //       title: doc.data['title'] ?? 'title',
  //     );
  //   }).toList();
  // }

  Stream<List<Products>> get productsStream {
    return cartCollection.snapshots().map(_productsSnapshot);
  }

  Stream<QuerySnapshot> get productSnapshot {
    return cartCollection.snapshots();
  }
}
