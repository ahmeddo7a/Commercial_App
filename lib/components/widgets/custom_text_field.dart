import 'package:flutter/material.dart';
import 'package:shop_application/components/constants/ui_constants.dart';

enum CustomTextType { pageHeader, description, header, caution ,custom}
class CustomText extends StatelessWidget {
  final String textLabel;
  final CustomTextType customTextType;
  final Color myTxtColors;
  final double myTxtSize;
  final int maxLine;
  final FontWeight myFontWeight;

  const CustomText(
      {
        Key? key,
        required this.textLabel,
        required this.customTextType,
        this.myTxtSize = MyUiSizes.normalSize,
        this.myTxtColors = MyUiColors.mainColor,
        this.maxLine = 2,
        this.myFontWeight=FontWeight.normal
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? txtColor;
    double? txtSize;

    switch(customTextType){
      case CustomTextType.pageHeader:
        txtColor = MyUiColors.mainColor;
        txtSize = MyUiSizes.pageHeaderSize;
        break;
      case CustomTextType.description:
        txtColor = Colors.grey;
        txtSize = MyUiSizes.smallSize;
        break;
      case CustomTextType.header:
        txtColor = MyUiColors.mainColor;
        txtSize = MyUiSizes.headerSize;
        break;
      case CustomTextType.caution:
        txtColor = MyUiColors.cautionColor;
        txtSize = MyUiSizes.ultraSmallSize;
        break;
      case CustomTextType.custom:
        txtColor =myTxtColors;
        txtSize=myTxtSize;
    }

    return Text(
      textLabel,
      maxLines: maxLine,
      style: TextStyle(
        color: txtColor,
        fontSize: txtSize,
        fontWeight: myFontWeight,
      ),
    );
  }
}
