import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/components/components.dart';
import 'package:shop_application/components/constants/ui_constants.dart';
import 'package:shop_application/components/widgets/spacer.dart';
import 'package:shop_application/features/home/logic/cubit.dart';
import 'package:shop_application/features/home/logic/states.dart';
import 'package:shop_application/features/home/models/categories_model.dart';
import 'package:shop_application/features/home/models/shop_model.dart';

import '../widgets/product_category_item_builder.dart';
import '../widgets/product_grid_builder.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){
        if(state is HomeSuccessChangeFavoritesState){
          if(!state.model.status!){
            showToast(text: state.model.message!, type: ToastTypes.ERROR);
          }
        }
      },
      builder: (context,state){
        return ConditionalBuilder(
            condition: HomeCubit.get(context).homeModel!=null && HomeCubit.get(context).categoriesModel!=null ,
            builder: (context) => productBuilder(context,HomeCubit.get(context).homeModel!,HomeCubit.get(context).categoriesModel!),
            fallback: (context)=> const Center(child: CircularProgressIndicator(),)
        );
      },
    );
  }

  Widget productBuilder(BuildContext context, HomeModel model, CategoriesModel categoriesModel){
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
              items: model.data!.banners!.map((e) => Image(
                  image: NetworkImage(e.image!),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
               ).toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                viewportFraction: 1,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
          ),
          const MySpacer(theHeight: 0.01,),
          Padding(
            padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Categories Text
                const Text(
                  'Categories',
                  style: TextStyle(
                    color: MyUiColors.mainColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const MySpacer(theHeight: 0.01,),

                //Category Items
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.12,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>BuildCategoryItem(model:categoriesModel.data!.data![index],),
                      separatorBuilder: (context,index) => const MySpacer(theWidth: 0.02,),
                      itemCount: categoriesModel.data!.data!.length,
                  ),
                ),

                const MySpacer(theHeight: 0.02,),
                //Products Text
                const Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24,
                    color: MyUiColors.mainColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const MySpacer(theHeight: 0.01,),
          //Products Items
          GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1/1.5,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                model.data!.products!.length,
                    (index) => BuildGridProductModel(model:model.data!.products![index]),
              ),
          )
        ],
      ),
    );
  }
}
