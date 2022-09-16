import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/features/auth/models/login_model.dart';
import 'package:shop_application/features/auth/register/cubit/states.dart';
import 'package:shop_application/network/remote/dio_helper.dart';
import 'package:shop_application/network/remote/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

   LoginModel? loginModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }){
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'email':email,
          'password':password,
          'name':name,
          'phone':phone,
        }
    ).then((value) {
      print(value.data);

      loginModel = LoginModel.fromJson(value.data);
        emit(RegisterSuccessState(loginModel));


    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
      print(error);
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = false;
  void changePasswordVisibility(){
    isPassword= !isPassword;
    suffix = isPassword?Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }

}