import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/userdatamodel.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}


class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccesHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}


class ShopLoadingCategoriesDataState extends ShopStates{}
class ShopSuccesCategoriesDataState extends ShopStates{}
class ShopErrorCategoriesDataState extends ShopStates{}

class ShopChangeFavoritesDataState extends ShopStates{}


class ShopSuccesChangeFavoritesDataState extends ShopStates{
  FavoritsModel? model;
  ShopSuccesChangeFavoritesDataState(this.model);
}
class ShopErrorChangeFavoritesDataState extends ShopStates{}

class ShopLoadingFavoritesDataState extends ShopStates{}
class ShopSuccesFavoritesDataState extends ShopStates{}
class ShopErrorFavoritesDataState extends ShopStates{}


class ShopLoadingSettingsDataState extends ShopStates{}
class ShopSuccesSettingsDataState extends ShopStates{}
class ShopErrorSettingsDataState extends ShopStates{}

class ShopUpDateUserDataLoadingState extends ShopStates{}
class ShopUpDateUserDataSuccessState extends ShopStates{
 final ShopLoginModel? loginModel;
  ShopUpDateUserDataSuccessState({this.loginModel});
}
class ShopUpDateUserDataErrorState extends ShopStates{
}