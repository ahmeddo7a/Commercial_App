import 'package:flutter/material.dart';
import 'package:shop_application/features/on_boarding/modal/on_boarding_modal.dart';

import '../../../components/widgets/custom_text_field.dart';
import '../../../components/widgets/spacer.dart';

class OnBoardingBuildItem extends StatelessWidget {
  final BoardingModal myModal;
  const OnBoardingBuildItem(
      {
        Key? key,
        required this.myModal,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Image(
                image: AssetImage(
                    myModal.image
                )
            )
        ),
        CustomText(
          textLabel: myModal.title,
          customTextType: CustomTextType.custom,
          myTxtSize: 22,
          myFontWeight: FontWeight.bold,
        ),
        const MySpacer(
          theHeight: 0.02,
        ),
        CustomText(
          textLabel: myModal.body,
          customTextType: CustomTextType.custom,
          myTxtSize: 14,
        ),

      ],
    );
  }
}
