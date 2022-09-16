class ChangeFavoritesModel{
  bool? status;
  String? message;
  ChangeFavoritesModel({
    required this.status,
    required this.message,
  });

  ChangeFavoritesModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}