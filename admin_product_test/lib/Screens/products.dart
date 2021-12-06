import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebutler/Shared/constants.dart';
import 'package:ebutler/providers/productdb.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '/Shared/appdrawer.dart';
import '/Services/auth.dart';
import '/Services/database.dart';
import '/Model/user.dart';
import '/providers/products.dart' as prod;

class Products extends StatefulWidget {
  static const routeName = '/';

  const Products({Key key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String id = '';
    String title = '';
    String price = '';
    String description = '';
    String imageUrl = '';

    bool idCheck = true;

    final user = Provider.of<User>(context);
    final product = Provider.of<prod.ProductsItem>(context);

    final AuthService _auth = AuthService();

    final justSnapshot = Provider.of<QuerySnapshot>(context);
    // for (var doc in justSnapshot.documents) {
    //   print(doc.data);
    // }
    // final testing = Provider.of<List<prod.Products>>(context);
    // print(testing.id);
    // for (int i = 0; i < testing.length; i++) {
    //   print(testing.toList()[i].id);
    //   print(testing.toList()[i].title);
    //   print(testing.toList()[i].description);
    //   print(testing.toList()[i].price);
    //   print(testing.toList()[i].imageURL);
    // }
    // testing.forEach((test) {
    //   print(test.id);
    //   print(test.title);
    //   print(test.description);
    //   print(test.price);
    //   print(test.imageURL);
    // });
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Products'),
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
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'title'),
                  onChanged: (val) {
                    title = val;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'id'),
                  onChanged: (val) {
                    for (int i = 0; i < product.productsCount; i++) {
                      if (val == product.products.values.toList()[i].id) {
                        idCheck = false;
                        break;
                      } else {
                        idCheck = true;
                      }
                    }
                    if (idCheck == true) {
                      id = val;
                    }
                  },
                  validator: (val) => val.isEmpty || idCheck == false
                      ? 'please enter id with unique id'
                      : null,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'price'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (val) {
                    price = val;
                  },
                  validator: (val) => val.isEmpty ? 'please enter price' : null,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'description'),
                  onChanged: (val) {
                    description = val;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'image url'),
                  onChanged: (val) {
                    imageUrl = val;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text('Add'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Provider.of<prod.ProductsItem>(context, listen: false)
                          .addItem(
                        id,
                        int.parse(price),
                        title,
                        description,
                        imageUrl,
                      );
                      _formKey.currentState.reset();
                    }
                  },
                ),
                RaisedButton(
                    child: Text(
                      'Send',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.purple,
                    onPressed: () {
                      DatabaseService(id: id).updateProductData(
                          id, title, int.parse(price), description, imageUrl);
                      _formKey.currentState.reset();
                      // for (int i = 0; i < product.productsCount; i++) {
                      //   DatabaseService(
                      //           id: product.products.values.toList()[i].id)
                      //       .updateProductData(
                      //           i,
                      //           product.products.values.toList()[i].id,
                      //           product.products.values.toList()[i].title,
                      //           product.products.values.toList()[i].price,
                      //           product.products.values.toList()[i].description,
                      //           product.products.values.toList()[i].imageURL);
                      // }
                    }),
                RaisedButton(
                    child: Text('Set up'),
                    onPressed: () {
                      DatabaseService(id: '0').setDocument();
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
