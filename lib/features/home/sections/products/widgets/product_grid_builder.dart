import 'package:flutter/material.dart';
import '../../../../../components/constants/ui_constants.dart';
import '../../../../../components/widgets/spacer.dart';
import '../../../logic/cubit.dart';
import '../../../models/shop_model.dart';

class BuildGridProductModel extends StatelessWidget {
  final Products model;
  const BuildGridProductModel(
      {
        Key? key,
        required this.model,

      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image!),
              width: double.infinity,
              height: MediaQuery.of(context).size.height*0.2,
              //fit: BoxFit.fill,
            ),
            if(model.discount!=0)
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
        const MySpacer(theHeight: 0.01,),
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.018,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
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
                    model.price.toString()+' Egp',
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.3,
                      color: MyUiColors.mainColor,
                    ),
                  ),
                  const MySpacer(theWidth: 0.01,),
                  if(model.discount!=0)
                    Text(
                      model.oldPrice.toString()+' Egp',
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
                      HomeCubit.get(context).changeFavorites(model.id!);
                    },
                    icon:  HomeCubit.get(context).favorites![model.id]! ?const Icon(Icons.favorite,size: 14,color: Colors.red,) : const Icon(Icons.favorite_border,size: 14,),
                  )

                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
