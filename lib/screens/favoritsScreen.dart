import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/const/colors.dart';
import 'package:shop_app/const/widgets.dart';
import 'package:shop_app/modules/shop_app/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/cubit/states.dart';

class FavoritScreen extends StatelessWidget {
  const FavoritScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) => ConditionalBuilder(
            condition: (state is !ShopLoadingFavoritesDataState),
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildFavoritItem(
                    ShopCubit.get(context)
                        .shopFavoritesModel!
                        .data!
                        .data[index]
                        .data,context),
                separatorBuilder: (context, index) => Divider(
                      thickness: 1.0,
                    ),
                itemCount: ShopCubit.get(context)
                    .shopFavoritesModel!
                    .data!
                    .data
                    .length),
            fallback: (context) => Center(
                    child: CircularProgressIndicator(
                  color: defaultColor,
                ))));
  }
}
