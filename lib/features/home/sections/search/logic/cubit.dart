import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/features/home/models/search_model.dart';
import 'package:shop_application/features/home/sections/search/logic/states.dart';
import 'package:shop_application/network/remote/dio_helper.dart';
import 'package:shop_application/network/remote/end_points.dart';

import '../../../../../components/components.dart';

class SearchCubit extends Cubit<SearchStates>{
  
  SearchCubit(): super(SearchInitialState());
  
  static SearchCubit get(context) => BlocProvider.of(context);
  
  SearchModel? searchModel;
  
  void search(String text){
    emit(SearchLoadingState());
    print('loading');
    
    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
          'text':text,
        }
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());

    });
    
  }
}