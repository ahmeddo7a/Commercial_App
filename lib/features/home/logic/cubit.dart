import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/components/components.dart';
import 'package:shop_application/features/auth/models/login_model.dart';
import 'package:shop_application/features/home/logic/states.dart';
import 'package:shop_application/features/home/models/favorites_model.dart';
import 'package:shop_application/features/home/models/myfavorites_model.dart';
import 'package:shop_application/features/home/sections/categories/screens/categories_screen.dart';
import 'package:shop_application/features/home/sections/favourites/screens/favourite_screen.dart';
import 'package:shop_application/features/home/sections/products/screens/product_screen.dart';
import 'package:shop_application/features/home/sections/settings/screens/settings_screen.dart';
import 'package:shop_application/network/remote/dio_helper.dart';
import 'package:shop_application/network/remote/end_points.dart';

import '../models/categories_model.dart';
import '../models/shop_model.dart';

class HomeCubit extends Cubit<HomeStates>{

  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);


  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const ProductScreen(),
    const CategoriesScreen(),
    const FavouriteScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index){
    currentIndex = index;
    print(index);
    emit(HomeChangeBottomNavState());
  }

     HomeModel? homeModel;
    Map<int, bool>? favorites = {};

  void getHomeData(){
    emit(HomeLoadingDataState());

    DioHelper.getData(
        url: HOME,
        token: token

    ).then((value){

          homeModel =HomeModel.fromJson(value.data);

          print(homeModel!.data!.banners![0].image);
          print(homeModel!.status);
          
          homeModel!.data!.products!.forEach((element) {
            favorites!.addAll({
              element.id!:element.inFavorites!
            });
          });
          print(favorites.toString());
          
          emit(HomeSuccessDataState());
    }).catchError((error){
      print(error.toString());
     emit(HomeErrorDataState());
    });

  }

     CategoriesModel? categoriesModel;

  void getCategories(){
    emit(HomeLoadingCategoriesDataState());

    DioHelper.getData(
        url: GET_CATEGORIES,
        token: token

    ).then((value){

      categoriesModel =CategoriesModel.fromJson(value.data);

      emit(HomeSuccessCategoriesDataState());
    }).catchError((error){
      print(error.toString());
      emit(HomeErrorCategoriesDataState());
    });

  }



  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId){

    favorites![productId] = !favorites![productId]!;
    emit(HomeChangeFavoritesState());

    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id':productId
        },
        token: token,
    ).then((value) {

      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      print(token);

      if(!changeFavoritesModel!.status!){
        favorites![productId] = !favorites![productId]!;
      }else{
        getFavorites();
      }

      emit(HomeSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error){
      favorites![productId] = !favorites![productId]!;
      emit(HomeErrorChangeFavoritesState());
    });

  }


  FavoritesModel? favoritesModel;

  void getFavorites(){

    emit(HomeLoadingGetFavoritesState());

    DioHelper.getData(
        url: FAVORITES,
        token: token

    ).then((value){

      favoritesModel =FavoritesModel.fromJson(value.data);
      print("favorites::"+favoritesModel.toString());

      emit(HomeSuccessGetFavoritesState());
    }).catchError((error){
      print(error.toString());
      emit(HomeErrorGetFavoritesState());
    });

  }


   LoginModel? userModel;

  void getUserData(){
    emit(HomeLoadingUserDataState());

    DioHelper.getData(
        url: PROFILE,
        token: token

    ).then((value){

      userModel =LoginModel.fromJson(value.data);

      emit(HomeSuccessUserDataState(userModel));
    }).catchError((error){
      print(error.toString());
      emit(HomeErrorUserDataState());
    });

  }


  void updateUserData({
    required String name,
    required String email,
    required String phone
}){
    emit(HomeLoadingUpdateUserState());

    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
        data: {
          'name':name,
          'email':email,
          'phone':phone,
        }

    ).then((value){

      userModel =LoginModel.fromJson(value.data);

      emit(HomeSuccessUpdateUserState(userModel));
    }).catchError((error){
      print(error.toString());
      emit(HomeErrorUpdateUserState());
    });

  }


}