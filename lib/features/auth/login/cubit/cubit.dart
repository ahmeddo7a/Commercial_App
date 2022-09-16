import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/features/auth/login/cubit/states.dart';
import 'package:shop_application/features/auth/models/login_model.dart';
import 'package:shop_application/network/remote/dio_helper.dart';
import 'package:shop_application/network/remote/end_points.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);



  void userLogin({
    required String email,
    required String password
}){
    late LoginModel loginModel;

    emit(LoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data: {
        'email':email,
        'password':password,
      }
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
      print(error);
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = false;
  void changePasswordVisibility(){
    isPassword= !isPassword;
    suffix = isPassword?Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePasswordVisibilityState());
  }

}