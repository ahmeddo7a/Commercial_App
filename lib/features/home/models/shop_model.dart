class HomeModel {
  HomeModel({
    required this.status,
    required this.data,
  });
   bool? status;
   Data? data;

  HomeModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = Data.fromJson(json['data']);
  }

}

class Data {
  Data({
    required this.banners,
    required this.products,
  });
   List<Banners>? banners;
   List<Products>? products;

  Data.fromJson(Map<String, dynamic> json){
    banners = List.from(json['banners']).map((e)=>Banners.fromJson(e)).toList();
    products = List.from(json['products']).map((e)=>Products.fromJson(e)).toList();
  }

}

class Banners {
  Banners({
    required this.id,
    required this.image,

  });
   int? id;
   late String? image;


  Banners.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];

  }

}

class Products {
  Products({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
    required this.images,
    required this.inFavorites,
    required this.inCart,
  });
    int? id;
   dynamic price;
   dynamic oldPrice;
   dynamic discount;
   late String? image;
   String? name;
   String? description;
   List<String>? images;
   bool? inFavorites;
   bool? inCart;

  Products.fromJson(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = List.castFrom<dynamic, String>(json['images']);
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

}