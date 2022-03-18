import 'package:flutter/material.dart';

import 'package:shop_app/const/navigator.dart';
import 'package:shop_app/network/local/cach_helper.dart';
import 'package:shop_app/screens/loginScreen.dart';

String ?token;

void logOut(context){
  CacheHelper.removeData(key: 'token').then((value){
    if(value){
      navigateToAndFinish(context, LoginScreen());
    }
  });
}