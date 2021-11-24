import 'package:flutter/foundation.dart';

class Products {
  final String id;
  final double price;
  final String description;
  final String imageURL;
  final String title;

  Products({this.id, this.price, this.description, this.imageURL, this.title});
}

class ProductsItem with ChangeNotifier {
  final Map<String, Products> _products = {};

  Map<String, Products> get products {
    return {..._products};
  }

  int get productsCount {
    return _products.length;
  }

  void addItem(
    String id,
    double price,
    String title,
    String description,
    String imageURL,
  ) {
    if (_products.containsKey(id)) {
      _products.update(
          id,
          (existingProducts) => Products(
              id: existingProducts.id,
              title: existingProducts.title,
              price: existingProducts.price,
              description: existingProducts.description,
              imageURL: existingProducts.imageURL));
    } else {
      _products.putIfAbsent(
          id,
          () => Products(
                id: id,
                title: title,
                description: description,
                imageURL: imageURL,
                price: price,
              ));
    }
    notifyListeners();
  }
  // void addOrder(String id, String description, String title, String imageURL,
  //     double price) {
  //   _products.insert(
  //     0,
  //     Products(
  //         id: id,
  //         price: price,
  //         description: description,
  //         imageURL: imageURL,
  //         title: title),
  //   );}
}
