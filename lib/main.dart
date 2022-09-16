import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/components/components.dart';
import 'package:shop_application/components/constants/ui_constants.dart';
import 'package:shop_application/features/auth/login/screens/login_screen.dart';
import 'package:shop_application/features/home/logic/cubit.dart';
import 'package:shop_application/features/home/screens/shop_home.dart';
import 'package:shop_application/features/on_boarding/screens/on_boarding_screen.dart';
import 'package:shop_application/network/local/cache_helper.dart';
import 'package:shop_application/network/remote/dio_helper.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');


  if (onBoarding != null) {
    if (token != null)
      widget = ShopHome();
    else
      widget = LoginScreen();
  }
  else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(widget));
}


class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp(this.startWidget, {Key? key,}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => HomeCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
            secondary: MyUiColors.mainColor,
            primary: MyUiColors.mainColor
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            elevation: 20.0,
            selectedItemColor: MyUiColors.buttonBackgroundColor,
          ),
        ),
        home: startWidget,
      ),
    );
  }
}




