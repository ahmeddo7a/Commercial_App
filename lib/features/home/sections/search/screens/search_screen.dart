import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/components/widgets/custom_button.dart';
import 'package:shop_application/components/widgets/custom_form_field.dart';
import 'package:shop_application/components/widgets/spacer.dart';
import 'package:shop_application/features/home/sections/search/logic/cubit.dart';
import 'package:shop_application/features/home/sections/search/logic/states.dart';

import '../../../../../components/components.dart';
import '../../../logic/cubit.dart';
import '../widgets/search_item_builder.dart';

class SearchScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();

   SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myWidth = MediaQuery.of(context).size.width;
    final myHeight = MediaQuery.of(context).size.height;

    return  BlocProvider(
        create: (BuildContext context) =>SearchCubit(),
        child: BlocConsumer<SearchCubit,SearchStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: Form(
                key: formKey,
                child: Padding(
                  padding:  EdgeInsets.only(
                      left: myWidth*0.05,
                      right: myWidth*0.05,
                      top:  myHeight*0.05
                  ),
                  child: Column(
                    children: [
                     Row(
                       children: [
                         Expanded(
                           flex: 3,
                           child: Container(
                             height: myHeight*0.06,
                             child: CustomFormField(
                                 customFieldType: CustomFieldType.custom,
                                 controller: searchController,
                                 validate: (String? value){
                                   if(value!.isEmpty){
                                     return ' enter text to search';
                                   }
                                 },
                                 label: 'Search',
                                 prefixIcon: Icons.search,
                             ),
                           ),
                         ),
                         Expanded(
                           flex: 1,
                           child: Container(
                             height: myHeight*0.06,
                             child: CustomButton(onPressed: ()
                             {
                               SearchCubit.get(context).search(searchController.text);
                               },
                                 buttonLabel: 'Search',
                                myBorderRadius: 5,
                             ),
                           ),
                         )
                       ],
                     ),
                      const MySpacer(theHeight: 0.02,),
                      if(state is SearchLoadingState)
                      const LinearProgressIndicator(),
                      const MySpacer(theHeight: 0.03,),
                      if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context,index) => SearchItemBuilder(
                              model: SearchCubit.get(context).searchModel!.data!.data![index],
                            ),
                            separatorBuilder: (context,index) => drawDivider(),
                            itemCount: SearchCubit.get(context).searchModel!.data!.data!.length
                        ),
                      ),
                    ],

                  ),
                ),
              ),
            );
          },
        ),
    );
  }
}
