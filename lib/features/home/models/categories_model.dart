class CategoriesModel{
   bool? status;
   CategoriesDataModel? data;

   CategoriesModel({
     required this.status,
     required this.data
   });

  CategoriesModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = json['data'] != null? CategoriesDataModel.fromJson(json['data'],): null;
  }
}

class CategoriesDataModel {
  int? current_page;
  List<DataModel>? data;

  CategoriesDataModel({
    required this.current_page,
    required this.data
  });

  CategoriesDataModel.fromJson(Map<String, dynamic> json){
    current_page = json['current_page'];
    if (json['data'] != null) {
      data = <DataModel>[];
      json['data'].forEach((v) {
        data!.add(DataModel.fromJson(v));
      });
    }
  }
}

class DataModel{
   int? id;
   String? name;
   String? image;

   DataModel({
     required this.id,
     required this.name,
     required this.image,
   });

  DataModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];

  }

}