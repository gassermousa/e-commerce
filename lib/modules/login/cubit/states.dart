import 'package:shop_app/models/userdatamodel.dart';

abstract class ShoploginState{}

class ShopLoginInitialState extends ShoploginState{}
class ShopLoginLoadingState extends ShoploginState{}

class ShopLoginSuccessState extends ShoploginState{
 final ShopLoginModel? loginModel;
  ShopLoginSuccessState({this.loginModel});
}
class ShopLoginErrorState extends ShoploginState{
  final error;
  ShopLoginErrorState(this.error);
}

class ShopLoginSuffixOconChange extends ShoploginState{}



