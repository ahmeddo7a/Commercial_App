import 'package:dio/dio.dart';

class DioHelper{
  static  Dio? dio;

   static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

   static Future getData({
      required String url,
      dynamic query,
      String lang = 'en',
      String? token,

   })async{
     dio!.options.headers =
     {
       'Content-Type':'application/json',
       'lang':lang,
       'Authorization':token??'',
     };
      return await dio!.get(
        url,
        queryParameters: query
      );
    }



   static Future postData({
      required String url,
     required dynamic data,
     dynamic query,
     String lang = 'en',
     String? token,

   })async{
     dio!.options.headers =
       {
         'Content-Type':'application/json',
         'lang':lang,
         'Authorization':token,
       };

        return await dio!.post(
          url,
          queryParameters: query,
          data: data
        );
   }


  static Future putData({
    required String url,
    required dynamic data,
    dynamic query,
    String lang = 'en',
    String? token,

  })async{
    dio!.options.headers =
    {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token,
    };

    return await dio!.put(
        url,
        queryParameters: query,
        data: data
    );
  }

}