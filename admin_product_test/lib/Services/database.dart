import 'package:cloud_firestore/cloud_firestore.dart';

import '/providers/products.dart';
import '/providers/productdb.dart';

class DatabaseService {
  final String id;
  DatabaseService({this.id});
//ini tu bwt ngisi yg uid: user.uid, jadi kalo mau pake data lain tinggal diganti
//ntar tinggal nama document nya disesuain dari yg diisi
//kayakny bs pake room number, uid ny gnti jd room number, room numbernya di sruh input sblm order now

  List<Products> _products = [];
  final CollectionReference cartCollection =
      Firestore.instance.collection('product');
  final CollectionReference infoCollection =
      Firestore.instance.collection('Information');
  Future setDocument() async {
    return await cartCollection.document(id).setData({});
  }

  Future setDocument1() async {
    return await infoCollection.document(id).setData({});
  }

  Future updateInformationData(
      int index, String id, String title, String description) async {
    Map<String, Object> informationsData = {
      'id': id,
      'title': title,
      'description': description,
    };

    return await infoCollection.document(id).updateData({
      '$index': informationsData,
    });
  }

  Future updateProductData(String id, String title, int price,
      String description, String imageUrl) async {
    Map<String, Object> productsData = {
      'id': id,
      'name': title,
      'price': price,
      'description': description,
      'url': imageUrl,
    };

    return await cartCollection.document(id).setData({
      'id': id,
      'name': title,
      'price': price,
      'description': description,
      'url': imageUrl,
    });
  }

  List<Products> _productsSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      int count = doc.data.length;
      // List<Products> prod = [];
      if (count != 0) {
        print('count: $count');
        // Product() = List.from(temp);
        for (int i = 0; i < count; i++) {
          print('i: $i');
          Products(
            id: doc.data['$i']['id'],
            price: doc.data['$i']['price'],
            description: doc.data['$i']['description'],
            imageURL: doc.data['$i']['imageurl'],
            title: doc.data['$i']['title'],
          );
          _products.insert(
            0,
            Products(
              id: doc.data['$i']['id'],
              price: doc.data['$i']['price'],
              description: doc.data['$i']['description'],
              imageURL: doc.data['$i']['imageurl'],
              title: doc.data['$i']['title'],
            ),
          );
          _products.add(Products(
            id: doc.data['$i']['id'],
            price: doc.data['$i']['price'],
            description: doc.data['$i']['description'],
            imageURL: doc.data['$i']['imageurl'],
            title: doc.data['$i']['title'],
          ));
        }
        return Products();
        // for (var i in _products) {
        //   print(i);
        // }
        // ;

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
