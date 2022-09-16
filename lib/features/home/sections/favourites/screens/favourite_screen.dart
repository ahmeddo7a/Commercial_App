import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/features/home/sections/favourites/widgets/favorites_item_builder.dart';

import '../../../../../components/components.dart';
import '../../../logic/cubit.dart';
import '../../../logic/states.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){
        if(state is HomeLoadingGetFavoritesState){
          print('Favorites Loading');

        }
        if(state is HomeSuccessGetFavoritesState){
          print('Favorites Success');
        }
      },
      builder: (context,state){
        return ConditionalBuilder(
          condition: state is! HomeLoadingGetFavoritesState,
          builder:(context)=> ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index) => FavoritesItemBuilder(model:HomeCubit.get(context).favoritesModel!.data!.data![index]),
              separatorBuilder: (context,index) => drawDivider(),
              itemCount: HomeCubit.get(context).favoritesModel!.data!.data!.length
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}
