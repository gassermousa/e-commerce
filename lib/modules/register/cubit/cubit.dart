import 'package:flutter/material.dart';
import 'package:shop_app/models/userdatamodel.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/network/remote/end_points.dart';

class ShopRegisterCUbit extends Cubit<ShopRegisterState> {
  ShopRegisterCUbit() : super(ShopRegisterInitialState());

  static ShopRegisterCUbit get(context) => BlocProvider.of(context);
   ShopLoginModel? RegisterModel;

  void userRegister({String? name,String? email, String? password,String? phone}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: Register, data: {
      'name': name,
      'email': email,
       'password': password,
       'phone': phone

       })
        .then((value) {
      RegisterModel = ShopLoginModel.fromJson(value.data);

      emit(ShopRegisterSuccessState(RegisterModel: RegisterModel));
    }).catchError((error) {
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changpassworedIcon() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterSuffixOconChange());
  }
}
