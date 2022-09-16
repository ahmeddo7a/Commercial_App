import 'package:flutter/material.dart';
import 'package:shop_application/features/home/models/myfavorites_model.dart';

import '../../../../../components/constants/ui_constants.dart';
import '../../../../../components/widgets/spacer.dart';
import '../../../logic/cubit.dart';

class FavoritesItemBuilder extends StatelessWidget {
  final FavoritesData model;
  const FavoritesItemBuilder({
    Key? key,
     required this.model
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width*0.05,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height*0.2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.product!.image!),
                  width: MediaQuery.of(context).size.width*0.3,
                  height: MediaQuery.of(context).size.height*0.2,
                  fit: BoxFit.cover,
                ),
                if(model.product!.discount !=0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.red,
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.white
                      ),
                    ),
                  ),
              ],
            ),
            const MySpacer(theWidth: 0.02,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    model.product!.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        model.product!.price!.toString()+' Egp',
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.3,
                          color: MyUiColors.mainColor,
                        ),
                      ),
                      const MySpacer(theWidth: 0.01,),
                      if(model.product!.discount !=0)
                        Text(
                          model.product!.oldPrice!.toString()+' Egp',
                          style: const TextStyle(
                              fontSize: 12,
                              height: 1.3,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: (){
                           HomeCubit.get(context).changeFavorites(model.product!.id!);
                        },
                        icon:  HomeCubit.get(context).favorites![model.product!.id]! ?const Icon(Icons.favorite,size: 14,color: Colors.red,) : const Icon(Icons.favorite_border,size: 14,),
                      )

                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
