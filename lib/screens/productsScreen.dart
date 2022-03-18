import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/const/colors.dart';
import 'package:shop_app/const/toast.dart';
import 'package:shop_app/const/widgets.dart';
import 'package:shop_app/modules/shop_app/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/cubit/states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccesChangeFavoritesDataState) {
          
          if (!state.model!.status!) {
            showToast(message: state.model!.message!, color: Colors.red);
          } 
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoriesModel != null,
            builder: (context) => productsScreenBuilder(
                ShopCubit.get(context).homeModel,
                ShopCubit.get(context).categoriesModel,
                context),
            fallback: (context) => Center(
                    child: CircularProgressIndicator(
                  color: defaultColor,
                )));
      },
    );
  }
}
