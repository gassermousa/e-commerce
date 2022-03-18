import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categoriesModel.dart';
import 'package:shop_app/modules/shop_app/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state){} ,
      builder: (context, state) => 
       ListView.separated(
         physics: BouncingScrollPhysics(),
        itemBuilder:(context,index)=>builderCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
        separatorBuilder: (context,index)=>Divider(),
        itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length),
    );
  }
  Widget builderCatItem(DataModel? model )=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: ListTile(
      leading: Image(
        image: NetworkImage(model!.image!),
        width: 80.0,height: 80.0,fit: BoxFit.cover,
      ),
      title: Text(model.name!),
      trailing: Icon(Icons.arrow_forward_ios),
    ),
  );
}