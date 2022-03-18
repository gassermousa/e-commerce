import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/const/constant.dart';
import 'package:shop_app/modules/shop_app/cubit/cubit.dart';
import 'package:shop_app/network/local/cach_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/screens/loginScreen.dart';
import 'package:shop_app/screens/onBoardingScreen.dart';
import 'package:shop_app/screens/shop_home.dart';
import 'package:shop_app/themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  bool? onboarding = CacheHelper.getdata(key: 'onBoarding');
  token = CacheHelper.getdata(key: 'token');
  
  print(token);
  Widget widget;
  if (onboarding != null) {
    if (token != null) {
      widget = ShopHomeScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(widget));
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  Widget? startWidget;
  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getHomeData()
        ..getCategoriesData()
        ..getFavoritesData()..getSettingsData(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: LightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          home: startWidget),
    );
  }
}
