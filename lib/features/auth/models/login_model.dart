class LoginModel{
   bool? status;
   String? message;
   UserData? data;
  LoginModel({
    required this.status,
    required this.data,
    required this.message,
  });

  LoginModel.fromJson(Map<String,dynamic>json){
    status = json['status'];
    message = json['message'];
    data = json['data'] != null? UserData.fromJson(json['data'],): null;
  }
}


class UserData{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.points,
    required this.credit,
    required this.token,
  });

    // Named Constructor
UserData.fromJson(Map<String,dynamic>json){
  id = json['id'];
  name = json['name'];
  email = json['email'];
  phone = json['phone'];
  image = json['image'];
  points = json['points'];
  credit = json['credit'];
  token = json['token'];



}

}