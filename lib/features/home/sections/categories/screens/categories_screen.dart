import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/components/components.dart';
import 'package:shop_application/components/widgets/spacer.dart';
import 'package:shop_application/features/home/logic/cubit.dart';
import 'package:shop_application/features/home/logic/states.dart';
import 'package:shop_application/features/home/models/categories_model.dart';

import '../../../../../components/constants/ui_constants.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index) => buildCatItem(context,HomeCubit.get(context).categoriesModel!.data!.data![index]),
              separatorBuilder: (context,index) => drawDivider(),
              itemCount: HomeCubit.get(context).categoriesModel!.data!.data!.length
          );
        },
    );
  }
  Widget buildCatItem(BuildContext context, DataModel model){
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width*0.02,
        vertical:  MediaQuery.of(context).size.height*0.02,
      ),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image!),
            width: MediaQuery.of(context).size.width*0.3,
            height: MediaQuery.of(context).size.height*0.13,
          ),
          const MySpacer(
            theWidth: 0.03,
          ),
          Text(
            model.name!,
            style: const TextStyle(
                color: MyUiColors.mainColor,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios),

        ],
      ),
    );
  }
}
