import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/features/auth/login/screens/login_screen.dart';
import 'package:shop_application/features/auth/register/cubit/cubit.dart';

import '../../../../components/components.dart';
import '../../../../components/constants/ui_constants.dart';
import '../../../../components/widgets/custom_button.dart';
import '../../../../components/widgets/custom_form_field.dart';
import '../../../../components/widgets/custom_text_field.dart';
import '../../../../components/widgets/spacer.dart';
import '../../../../network/local/cache_helper.dart';
import '../../../home/screens/shop_home.dart';
import '../cubit/states.dart';

class RegisterScreen extends StatelessWidget {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
   RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myWidth = MediaQuery.of(context).size.width;
    final myHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
        create: (BuildContext context)=> RegisterCubit(),
        child: BlocConsumer<RegisterCubit,RegisterStates>(
          listener: (context, state) {
            if(state is RegisterSuccessState){
              print('success registerState');
              if(state.loginModel!.status!){
                  CacheHelper.saveData(
                      key: 'token',
                      value: state.loginModel!.data!.token
                  ).then((value) =>
                  {
                    token = state.loginModel!.data!.token,
                    navigateAndFinish(
                        context,
                        ShopHome()
                    ),
                  });
              }else{
                print('Wrong data found');
                print(state.loginModel!.message);
                print('wrong');
                showToast(
                    text: state.loginModel!.message!,
                    type: ToastTypes.ERROR
                );
              }
            }


          },
          builder: (context,state){
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: myWidth*0.05,
                        vertical: myHeight*0.05
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            textLabel: 'REGISTER',
                            customTextType: CustomTextType.custom,
                            myFontWeight: FontWeight.bold,
                            myTxtSize: 32,
                            myTxtColors: MyUiColors.mainColor,
                          ),
                          const MySpacer(theHeight: 0.02,),
                          const CustomText(
                            textLabel: 'register now to browse our hot offers',
                            customTextType: CustomTextType.header,
                          ),
                          const MySpacer(theHeight: 0.04,),
                          CustomFormField(
                            customFieldType: CustomFieldType.name,
                            controller: nameController,
                            label: 'Name',
                            validate:(String? value){
                              if(value!.isEmpty){
                                return 'Please enter your Name';
                              }
                            },
                            prefixIcon: Icons.person,
                          ),
                          const MySpacer(theHeight:0.02),
                          CustomFormField(
                            customFieldType: CustomFieldType.phone,
                            controller: phoneController,
                            label: 'Phone Number',
                            validate:(String? value){
                              if(value!.isEmpty){
                                return 'Please enter your Phone Number';
                              }
                            },
                            prefixIcon: Icons.phone,
                          ),
                          const MySpacer(theHeight:0.02),
                          CustomFormField(
                            customFieldType: CustomFieldType.email,
                            controller: emailController,
                            label: 'Email',
                            validate:(String? value){
                              if(value!.isEmpty){
                                return 'Please enter your email address';
                              }
                            },
                            prefixIcon: Icons.email_outlined,
                          ),
                          const MySpacer(theHeight:0.02),
                          CustomFormField(
                            customFieldType: CustomFieldType.password,
                            controller: passwordController,
                            label: 'Password',
                            validate:(String? value){
                              if(value!.isEmpty){
                                return 'Password is to short';
                              }
                            },
                            prefixIcon: Icons.email_outlined,
                            suffixIcon: RegisterCubit.get(context).suffix,
                            suffixPressed: (){
                              RegisterCubit.get(context).changePasswordVisibility();
                            },
                            isPassword: RegisterCubit.get(context).isPassword,
                          ),
                          const MySpacer(theHeight: 0.03),
                          SizedBox(
                            width: myWidth,
                            height: myHeight*0.055,
                            child:  ConditionalBuilder(
                              condition: state is! RegisterLoadingState,
                              builder: (context) => CustomButton(
                                onPressed: (){
                                  if(formKey.currentState!.validate()) {
                                    RegisterCubit.get(context).userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text
                                    );
                                    print('nice');
                                  }else{
                                    print('not validate');
                                  }
                                },
                                buttonLabel: 'REGISTER',
                                myFontWeight: FontWeight.bold,
                                myFontSize: 18,
                                myBorderRadius: MyUiSizes.smallRadius,
                              ),
                              fallback: (context) => const Center(child: CircularProgressIndicator()),
                            ),
                          ),
                          const MySpacer(theHeight: 0.02,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CustomText(
                                textLabel: 'Already have an account  ',
                                customTextType: CustomTextType.custom,
                                myTxtSize: MyUiSizes.normalSize,
                                myFontWeight: FontWeight.normal,
                                myTxtColors: MyUiColors.mainColor,
                              ),
                              TextButton(
                                onPressed: (){
                                  navigateTo(context, LoginScreen());
                                },
                                child: const CustomText(
                                  textLabel: 'LOGIN',
                                  customTextType: CustomTextType.custom,
                                  myTxtSize: MyUiSizes.normalSize,
                                  myTxtColors: Colors.blue,
                                  myFontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        ),
        );
  }
}
