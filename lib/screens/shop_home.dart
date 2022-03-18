import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/const/colors.dart';
import 'package:shop_app/const/navigator.dart';
import 'package:shop_app/modules/shop_app/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/cubit/states.dart';
import 'package:shop_app/network/local/cach_helper.dart';
import 'package:shop_app/screens/loginScreen.dart';
import 'package:shop_app/screens/searchScreen.dart';

class ShopHomeScreen extends StatelessWidget {
  const ShopHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
        appBar: AppBar(
          title: Center(child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text('My',style: TextStyle(color: defaultColor,),),
               Text('Bag',style: TextStyle(color: Colors.black45,fontStyle: FontStyle.italic),),
              // ignore: prefer_const_constructors
              Icon(Icons.shopping_bag_outlined,color: defaultColor,)
            ],
          )),
          actions: [
            IconButton(onPressed: (){
              navigateTo(context, SearchScreen());
            }, icon: Icon(Icons.search)),
          ],
        ),
        body: cubit.BottomScreen[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index){
            cubit.changeBottomNav(index);
          },
          currentIndex: cubit.currentIndex,
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            // ignore: prefer_const_constructors
            BottomNavigationBarItem(
              icon:Icon(Icons.home),
              label: 'Home'
              ),
              BottomNavigationBarItem(
              icon:Icon(Icons.apps),
              label: 'Categories'
              ),
              BottomNavigationBarItem(
              icon:Icon(Icons.favorite),
              label: 'Favorite'
              ),
              BottomNavigationBarItem(
              icon:Icon(Icons.settings),
              label: 'settings'
              ),
              
          ],
        ),
      );
      }
    );
  }
}

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) navigateToAndFinish(context, LoginScreen());
  });
}
