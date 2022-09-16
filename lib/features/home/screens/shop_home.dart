import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/components/components.dart';
import 'package:shop_application/components/constants/ui_constants.dart';
import 'package:shop_application/features/home/logic/cubit.dart';
import 'package:shop_application/features/home/logic/states.dart';
import 'package:shop_application/features/home/sections/search/screens/search_screen.dart';


class ShopHome extends StatelessWidget  {
  const ShopHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = HomeCubit.get(context);

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('Amazon',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: MyUiColors.mainColor),),
              actions: [
                IconButton(
                    onPressed: (){
                      navigateTo(context, SearchScreen());
                    },
                    icon: const Icon(Icons.search),color: MyUiColors.mainColor,)
              ],
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            body :cubit.bottomScreens[cubit.currentIndex],

            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                cubit.changeBottom(index);
              },
              currentIndex: cubit.currentIndex,
              items: const[
                BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorites'),
                BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
              ],
            ),
          );
        },
    );
  }
}
