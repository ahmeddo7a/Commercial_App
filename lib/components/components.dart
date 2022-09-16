import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../features/auth/login/screens/login_screen.dart';
import '../network/local/cache_helper.dart';

void navigateTo(context,widget){
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context)=> widget,
    ),
  );
}

void navigateAndFinish(context,widget){
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context)=> widget,
      ),
      (Route<dynamic> route){
        return false;
      },
  );

}


enum ToastTypes{SUCCESS,ERROR,WARNING}
Color chooseToastColor(ToastTypes type){
  Color color;
  switch(type){
    case ToastTypes.SUCCESS:
      color= Colors.green;
      break;
    case ToastTypes.ERROR:
      color= Colors.red;
      break;
    case ToastTypes.WARNING:
      color= Colors.amber;
      break;
  }
  return color;
}
void showToast({required String text,required ToastTypes type}){
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(type),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) => {
    if(value){
      navigateAndFinish(context, LoginScreen()),
    }
  });
}

String? token ;

Widget drawDivider() {
  return Container(
    height: 1,
    width: double.infinity,
    color: Colors.grey.shade100,
  );
}