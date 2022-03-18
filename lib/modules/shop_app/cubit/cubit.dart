
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/const/constant.dart';
import 'package:shop_app/models/categoriesModel.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorits_model.dart';
import 'package:shop_app/models/homeModel.dart';
import 'package:shop_app/models/userdatamodel.dart';
import 'package:shop_app/modules/shop_app/cubit/states.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/network/remote/end_points.dart';
import 'package:shop_app/screens/categoriesSceen.dart';
import 'package:shop_app/screens/favoritsScreen.dart';
import 'package:shop_app/screens/productsScreen.dart';
import 'package:shop_app/screens/settingsScreen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> BottomScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritScreen(),
    SettingsSceen()
  ];

  Map<int?, bool?> favorits = {};

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getdat(url: home, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      // ignore: avoid_function_literals_in_foreach_calls
      homeModel!.data!.products.forEach((element) {
        favorits.addAll({element.id: element.inFavorit});
      });
      emit(ShopSuccesHomeDataState());
    }).catchError((error) {
      print(error.toString());
      print('error');
      print('getHomeData');
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getdat(url: categories, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccesCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      print('error');
      print('getCategoriesData');
      emit(ShopErrorCategoriesDataState());
    });
  }

  FavoritsModel? favoritsModel;
  void changeFavorites(int? productId) {
    favorits[productId] = !favorits[productId]!;
    emit(ShopChangeFavoritesDataState());
    DioHelper.postData(
        token: token,
        url: getFavorites,
        data: {'product_id': productId}).then((value) {
      favoritsModel = FavoritsModel.fromJson(value.data);
      emit(ShopSuccesChangeFavoritesDataState(favoritsModel));
      print(value.data);
      if (!favoritsModel!.status!) {
        favorits[productId] = !favorits[productId]!;
      } else {
        getFavoritesData();
      }
      emit(ShopSuccesChangeFavoritesDataState(favoritsModel));
    }).catchError((error) {
      favorits[productId] = !favorits[productId]!;
      emit(ShopErrorChangeFavoritesDataState());
    });
  }

/////////////////////////////////////////////////////////////////////////////////////////////
  ShopFavoritesModel? shopFavoritesModel;
  void getFavoritesData() {
    emit(ShopLoadingFavoritesDataState());
    DioHelper.getdat(url: getFavorites, token: token).then((value) {
      shopFavoritesModel = ShopFavoritesModel.fromJson(value.data);
      print(value.data.toString());
      print(shopFavoritesModel!.data!.data.length.toString());
      emit(ShopSuccesFavoritesDataState());
    }).catchError((error) {
      print(error.toString());
      print('error');
      print('getFavoritesData');

      emit(ShopErrorFavoritesDataState());
    });
  }

  ShopLoginModel? modelData;
  void getSettingsData() {
    emit(ShopLoadingSettingsDataState());
    DioHelper.getdat(url: getProfile, token: token).then((value) {
      modelData = ShopLoginModel.fromJson(value.data);
      print(value.data.toString());
      print(modelData!.data!.name);
      emit(ShopSuccesSettingsDataState());
    }).catchError((error) {
      print(error.toString());
      print('error');
      print('getSettingsData');

      emit(ShopErrorSettingsDataState());
    });
  }



  void upDtaeUserData(
    {
     required String name, required String email,required String phone
    }
  ) {
    emit(ShopUpDateUserDataLoadingState());
    DioHelper.putData(
      url: upDateProfile, 
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      }
      ).then((value) {
      modelData = ShopLoginModel.fromJson(value.data);
      print('upDtaeUserData');
      print(modelData!.message!);
      emit(ShopUpDateUserDataSuccessState(loginModel: modelData));
    }).catchError((error) {
      print(error.toString());
      print('error');
     

      emit(ShopUpDateUserDataErrorState());
    });
  }


  bool isDismissed = false;
  void getdismissed(int? productId) {
    changeFavorites(productId);
    isDismissed= !isDismissed;
  }
}
