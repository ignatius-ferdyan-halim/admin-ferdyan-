import 'package:ebutler/Screens/informationpage.dart';
import 'package:flutter/foundation.dart';

class Informations {
  final String id;

  final String description;

  final String title;

  Informations({this.id, this.description, this.title});
}

class Informationlist with ChangeNotifier {
  final Map<String, Informations> _informations = {};

  Map<String, Informations> get informations {
    return {..._informations};
  }

  int get informationsCount {
    return _informations.length;
  }

  void addInfo(
    String id,
    String title,
    String description,
  ) {
    if (_informations.containsKey(id)) {
      _informations.update(
          id,
          (existingProducts) => Informations(
                id: existingProducts.id,
                title: existingProducts.title,
                description: existingProducts.description,
              ));
    } else {
      _informations.putIfAbsent(
          id,
          () => Informations(
                id: id,
                title: title,
                description: description,
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
