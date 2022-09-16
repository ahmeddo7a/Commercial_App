class SearchModel {
  bool? status;
  SearchData? data;

  SearchModel({
    required this.status,
    required this.data
  });

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = SearchData.fromJson(json['data']);
  }
}

class SearchData {
  int? currentPage;
  List<SearchProduct>? data;


  SearchData(
      {
        required this.currentPage,
        required this.data,

      });

  SearchData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <SearchProduct>[];
      json['data'].forEach((v) {
        data!.add(SearchProduct.fromJson(v));
      });
    }
  }
}


class SearchProduct {
  int? id;
  dynamic price;
  String? image;
  String? name;

  SearchProduct(
      {
        required this.id,
        required this.price,
        required this.image,
        required this.name,
      });

  SearchProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
  }
}