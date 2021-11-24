import 'package:cloud_firestore/cloud_firestore.dart';

import '/providers/products.dart';

class DatabaseService {
  final String id;
  DatabaseService({this.id});
//ini tu bwt ngisi yg uid: user.uid, jadi kalo mau pake data lain tinggal diganti
//ntar tinggal nama document nya disesuain dari yg diisi
//kayakny bs pake room number, uid ny gnti jd room number, room numbernya di sruh input sblm order now
  final CollectionReference cartCollection =
      Firestore.instance.collection('Products');

  // Future setDocument() async {
  //   return await cartCollection.document(uid).setData({});
  // }

  Future updateProductData(String id, String title, double price,
      String description, String imageUrl) async {
    // Map<String, Object> products = {
    //   'title': title,
    //   'price': price,
    //   'description': description,
    //   'imageurl': imageUrl
    // };
    return await cartCollection.document(id).setData({
      'title': title,
      'price': price,
      'description': description,
      'imageurl': imageUrl
    });
    // .updateData({'products $id': products});
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

  // Stream<List<Products>> get productsStream {
  //   return cartCollection.snapshots().map(_productsSnapshot);
  // }

  // Stream<QuerySnapshot> get productSnapshot {
  //   return cartCollection.snapshots();
  // }

}
