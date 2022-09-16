import 'package:flutter/material.dart';
import 'package:shop_application/features/home/models/search_model.dart';

import '../../../../../components/constants/ui_constants.dart';
import '../../../../../components/widgets/spacer.dart';
import '../../../logic/cubit.dart';
import '../../../models/myfavorites_model.dart';

class SearchItemBuilder extends StatelessWidget {
  final SearchProduct model;
  const SearchItemBuilder({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: NetworkImage(model.image!),
            width: MediaQuery.of(context).size.width*0.3,
            height: MediaQuery.of(context).size.height*0.2,
          ),
          const MySpacer(theWidth: 0.02,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      model.price!.toString()+' Egp',
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.3,
                        color: MyUiColors.mainColor,
                      ),
                    ),

                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
