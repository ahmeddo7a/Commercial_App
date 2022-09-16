import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_application/components/components.dart';
import 'package:shop_application/components/widgets/custom_text_field.dart';
import 'package:shop_application/components/widgets/spacer.dart';
import 'package:shop_application/features/on_boarding/modal/on_boarding_modal.dart';
import 'package:shop_application/features/on_boarding/widget/on_boarding_widget.dart';
import 'package:shop_application/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../auth/login/screens/login_screen.dart';




class OnBoardingScreen extends StatefulWidget {


  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final List<BoardingModal> boarding =[
    BoardingModal(body: 'On Boarding 1 body', image: 'assets/images/on_boarding_1.jpg', title: 'On Boarding 1 title'),
    BoardingModal(body: 'On Boarding 2 body', image: 'assets/images/on_boarding_1.jpg', title: 'On Boarding 2 title'),
    BoardingModal(body: 'On Boarding 3 body', image: 'assets/images/on_boarding_1.jpg', title: 'On Boarding 3 title'),
  ];

  final PageController boardController =PageController();
  bool isLast = false;

  void submit(){
    navigateAndFinish(context, LoginScreen());
    CacheHelper.saveData(key: 'onBoarding', value: true,).then((value){
      if(value){
        navigateAndFinish(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final myWidth = MediaQuery.of(context).size.width;
    final myHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              onPressed: submit,
              child: const CustomText(
                  textLabel: 'SKIP',
                  customTextType: CustomTextType.header,
                  myFontWeight:FontWeight.bold ,
              )
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: myHeight*0.05,
          horizontal: myWidth*0.1
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                  onPageChanged: (int index){
                    if(index == boarding.length -1){
                      setState(() {
                        isLast = true;
                      });
                    } else{
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  itemBuilder: (context, index) => OnBoardingBuildItem(myModal: boarding[index],),
                  itemCount: boarding.length,
              ),
            ),
            const MySpacer(
              theHeight: 0.1,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                ),
                const Spacer(),
                FloatingActionButton(
                    onPressed: (){
                      if(isLast){
                        submit();
                      }else{
                        boardController.nextPage(
                            duration: const Duration(
                                milliseconds: 750
                            ),
                            curve: Curves.fastLinearToSlowEaseIn
                        );
                      }
                    },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



