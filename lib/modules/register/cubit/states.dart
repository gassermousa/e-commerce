import 'package:shop_app/models/userdatamodel.dart';

abstract class ShopRegisterState{}

class ShopRegisterInitialState extends ShopRegisterState{}
class ShopRegisterLoadingState extends ShopRegisterState{}

class ShopRegisterSuccessState extends ShopRegisterState{
 final ShopLoginModel? RegisterModel;
  ShopRegisterSuccessState({this.RegisterModel});
}
class ShopRegisterErrorState extends ShopRegisterState{
  final error;
  ShopRegisterErrorState(this.error);
}

class ShopRegisterSuffixOconChange extends ShopRegisterState{}
