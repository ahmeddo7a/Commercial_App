import 'package:flutter/material.dart';

import '../../../models/categories_model.dart';

class BuildCategoryItem extends StatelessWidget {
 final DataModel model;

  const BuildCategoryItem(
      {
        Key? key,
        required this.model
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image!),
          height: MediaQuery.of(context).size.height*0.12,
          width: MediaQuery.of(context).size.width*0.3,
          fit: BoxFit.cover,),
        Container(
            width: MediaQuery.of(context).size.width*0.3,
            color:Colors.black.withOpacity(0.8),
            child:  Text(
              model.name!,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white
              ),
            )
        )
      ],
    );
  }
}
