import 'package:flutter/material.dart';
import 'package:shop_application/components/constants/ui_constants.dart';

class CustomButton extends StatelessWidget {
  final String buttonLabel;
  final Function() onPressed;
  final Color backgroundColor;
  final double myFontSize;
  final FontWeight myFontWeight;
  final Color myTextColor;
  final double myPadding;
  final double myBorderRadius;

  const CustomButton(
      {
        Key? key,
        required this.onPressed,
        required this.buttonLabel,
        this.myTextColor=Colors.white,
        this.backgroundColor=MyUiColors.buttonBackgroundColor,
        this.myFontSize=MyUiSizes.normalSize,
        this.myFontWeight=FontWeight.normal,
        this.myPadding=3,
        this.myBorderRadius=0,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.all(myPadding)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(myBorderRadius),
            side: BorderSide(
              color: backgroundColor
            ),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
      ),
      child: Text(
        buttonLabel,
        style: TextStyle(
            color: myTextColor, fontSize: myFontSize, fontWeight: myFontWeight),
      ),
    );
  }
}
