class ProductDB {
  final String id;
  final int price;
  final String description;
  final String imageURL;
  final String title;

  ProductDB({this.id, this.price, this.description, this.imageURL, this.title});
  Map<String, ProductDB> productDB = {};

  Map<String, ProductDB> get products {
    return {...productDB};
  }

  int get count {
    return productDB.length;
  }
}
