import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/const/constant.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/network/remote/end_points.dart';

class SearchCubit extends Cubit<SearchState>
{
  SearchCubit() : super(SearchIntialState());

  static SearchCubit get(context)=>BlocProvider.of(context);

  ShopSearchModel ?model;
  void search(String? text){
    emit(SearchLoadinfState());
    DioHelper.postData(
      url: Search,
       token: token,
       data: {
      'text':text
    }
    ).then((value) {
      model=ShopSearchModel.fromJson(value.data);      
      emit(SearchSuccessState());
      print(model!.data!.data.length);
    }).catchError((error){
      emit(SearchErrorState());
      print(error.toString());
       
    });
  }
}