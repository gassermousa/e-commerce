import 'package:flutter/material.dart';
import 'package:shop_app/models/userdatamodel.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/network/remote/end_points.dart';

class ShopLoginCUbit extends Cubit<ShoploginState> {
  ShopLoginCUbit() : super(ShopLoginInitialState());

  static ShopLoginCUbit get(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel;

  void userLogin({String? email, String? password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: login, data: {'email': email, 'password': password})
        .then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);

      emit(ShopLoginSuccessState(loginModel: loginModel));
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changpassworedIcon() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopLoginSuffixOconChange());
  }
}
