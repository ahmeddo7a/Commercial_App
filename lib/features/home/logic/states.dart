import 'package:shop_application/features/auth/models/login_model.dart';
import 'package:shop_application/features/home/models/favorites_model.dart';

abstract class HomeStates{}
class HomeInitialState extends HomeStates{}

class HomeChangeBottomNavState extends HomeStates{}

class HomeLoadingDataState extends HomeStates{}
class HomeSuccessDataState extends HomeStates{}
class HomeErrorDataState extends HomeStates{}

class HomeLoadingCategoriesDataState extends HomeStates{}
class HomeSuccessCategoriesDataState extends HomeStates{}
class HomeErrorCategoriesDataState extends HomeStates{}

class HomeSuccessChangeFavoritesState extends HomeStates{
  late final ChangeFavoritesModel model;
  HomeSuccessChangeFavoritesState(this.model);
}
class HomeChangeFavoritesState extends HomeStates{}

class HomeErrorChangeFavoritesState extends HomeStates{}

class HomeLoadingGetFavoritesState extends HomeStates{}
class HomeSuccessGetFavoritesState extends HomeStates{}
class HomeErrorGetFavoritesState extends HomeStates{}


class HomeLoadingUpdateUserState extends HomeStates{}
class HomeSuccessUpdateUserState extends HomeStates{
  final LoginModel? loginModel;

  HomeSuccessUpdateUserState(
      this.loginModel
      );
}
class HomeErrorUpdateUserState extends HomeStates{}


class HomeLoadingUserDataState extends HomeStates{}
class HomeSuccessUserDataState extends HomeStates{
  final LoginModel? loginModel;

  HomeSuccessUserDataState(
      this.loginModel
      );
}
class HomeErrorUserDataState extends HomeStates{}