class FavoritesModel {
  bool? status;
  Data? data;

  FavoritesModel({
    required this.status,
    required this.data
  });

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  int? currentPage;
  List<FavoritesData>? data;


  Data(
      {
        required this.currentPage,
        required this.data,

      });

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FavoritesData>[];
      json['data'].forEach((v) {
        data!.add(FavoritesData.fromJson(v));
      });
    }
  }
}

class FavoritesData {
  int? id;
  Product? product;

  FavoritesData({
    required this.id,
    required this.product
  });

  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }

}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;

  Product(
      {
        required this.id,
        required this.price,
        required this.oldPrice,
        required this.discount,
        required this.image,
        required this.name,
      });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}