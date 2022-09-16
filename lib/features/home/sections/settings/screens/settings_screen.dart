import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/components/components.dart';
import 'package:shop_application/components/widgets/custom_button.dart';
import 'package:shop_application/components/widgets/custom_form_field.dart';
import 'package:shop_application/features/home/logic/cubit.dart';
import 'package:shop_application/features/home/logic/states.dart';

import '../../../../../components/constants/ui_constants.dart';
import '../../../../../components/widgets/spacer.dart';

class SettingsScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();


   SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myWidth = MediaQuery.of(context).size.width;
    final myHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        var model = HomeCubit.get(context).userModel!;
        nameController.text = model.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return ConditionalBuilder(
            condition: HomeCubit.get(context).userModel!=null ,
            builder: (context) => Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: myWidth*0.05,
                  vertical: myHeight*0.05
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is HomeLoadingUpdateUserState)
                    const LinearProgressIndicator(),
                    const MySpacer(theHeight: 0.02,),
                    CustomFormField(
                      customFieldType: CustomFieldType.name,
                      controller: nameController,
                      label: 'Username',
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'name must not be empty';
                        }
                      },
                      prefixIcon: Icons.person,
                    ),
                    const MySpacer(theHeight: 0.02,),
                    CustomFormField(
                      customFieldType: CustomFieldType.email,
                      controller: emailController,
                      label: 'Email',
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'email must not be empty';
                        }
                      },
                      prefixIcon: Icons.mail_outline,
                    ),
                    const MySpacer(theHeight: 0.02,),
                    CustomFormField(
                      customFieldType: CustomFieldType.phone,
                      controller: phoneController,
                      label: 'Phone',
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'phone must not be empty';
                        }
                      },
                      prefixIcon: Icons.phone,
                    ),
                    const MySpacer(theHeight: 0.03,),
                    SizedBox(
                      height: myHeight*0.05,
                      width: double.infinity,
                      child: CustomButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            HomeCubit.get(context).updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text
                            );
                          }
                        },
                        buttonLabel: 'Update',
                        myFontWeight: FontWeight.bold,
                        myFontSize: 18,
                      ),
                    ),
                    const MySpacer(theHeight: 0.03,),
                    SizedBox(
                      height: myHeight*0.05,
                      width: double.infinity,
                      child: CustomButton(
                          onPressed: (){signOut(context);},
                          buttonLabel: 'Sign Out',
                          myFontWeight: FontWeight.bold,
                          myFontSize: 18,
                      ),
                    ),

                  ],

                ),
              ),
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator())
        );
      },
    );
  }
}
