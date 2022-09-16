import 'package:flutter/material.dart';
import 'package:shop_application/components/constants/ui_constants.dart';

enum CustomFieldType { email, name, password, repeatPassword, phone, custom }
class CustomFormField extends StatelessWidget {

  final Function? onSubmit;
  final Function(String)? onChange;
  final Function? onTap;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final void Function()? suffixPressed;
  final CustomFieldType customFieldType;
  final TextEditingController controller;
  final String? Function(String?)? validate;
  final String label;
  final Color myCursorColor;
  final double myBorderRadius;
  final Color textColor;
  final bool isPassword;

  const CustomFormField(
      {
        Key? key,
        required this.customFieldType,
        required this.controller,
        required this.label,
        this.prefixIcon,
        this.onSubmit,
        this.onChange,
        this.onTap,
        this.suffixIcon,
        this.suffixPressed,
        this.validate,
        this.myCursorColor=Colors.black54,
        this.myBorderRadius=MyUiSizes.smallRadius,
        this.textColor=MyUiColors.mainColor,
        this.isPassword =false,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextInputType? type;
    String? formFieldLabel;
    IconData? customPrefix;
    switch(customFieldType){
      case CustomFieldType.name:
        formFieldLabel='Username';
        type=TextInputType.name;
        customPrefix = Icons.account_circle_outlined;
        break;
      case CustomFieldType.email:
        formFieldLabel = 'Email';
        type=TextInputType.emailAddress;
        customPrefix=Icons.mail_outline;
        break;
      case CustomFieldType.phone:
        formFieldLabel="Phone Number";
        type=TextInputType.phone;
        customPrefix=Icons.phone;
        break;
      case CustomFieldType.password:
        formFieldLabel='Password';
        type=TextInputType.visiblePassword;
        customPrefix=Icons.lock_outline;
        break;
      case CustomFieldType.repeatPassword:
        formFieldLabel="Repeat Password";
        type=TextInputType.visiblePassword;
        customPrefix=Icons.lock_outline;
        break;
      case CustomFieldType.custom:
        formFieldLabel=label;
        type=TextInputType.text;
        break;
    }
    return TextFormField(
      validator: validate,
      controller: controller,
      cursorColor: myCursorColor,
      onChanged: onChange,
      keyboardType: type,
      obscureText: customFieldType == CustomFieldType.password ||
          customFieldType == CustomFieldType.repeatPassword
          ? !isPassword
          : isPassword,
      style:  TextStyle(color: textColor),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide:  BorderSide(width: 0.5, color: myCursorColor),
          borderRadius: BorderRadius.circular(myBorderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(width: 0.5, color: myCursorColor),
          borderRadius: BorderRadius.circular(myBorderRadius),
        ),
        labelText: formFieldLabel,
        labelStyle:  TextStyle(color: myCursorColor),
        prefixIcon: Icon(customPrefix,color: myCursorColor,),
        suffixIcon: IconButton(
          icon: Icon(suffixIcon,color: myCursorColor,),
          onPressed: suffixPressed,
        ),
      ),
    );
  }
}