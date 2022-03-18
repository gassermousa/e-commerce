import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/const/colors.dart';
import 'package:shop_app/models/categoriesModel.dart';
import 'package:shop_app/models/favorits_model.dart';
import 'package:shop_app/models/homeModel.dart';
import 'package:shop_app/modules/shop_app/cubit/cubit.dart';

 
Widget productsScreenBuilder(
    HomeModel? model, CategoriesModel? categoriesModel, context) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CarouselSlider(
            items: model!.data!.banners
                .map(
                  (e) => ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: Container(
                      child: Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            )),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 15.0,
              ),
              SizedBox(
                height: 100.0,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildCategoriesItem(categoriesModel!.data!.data[index]),
                    separatorBuilder: (context, index) => SizedBox(
                          width: 10.0,
                        ),
                    itemCount: categoriesModel!.data!.data.length),
              ),
              Text(
                'New Products',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1.5,
              crossAxisSpacing: 4,
              childAspectRatio: 1 / 1.68,
              children: List.generate(
                  model.data!.products.length,
                  (index) => ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: buildGridProduct(
                            model.data!.products[index], context),
                      )),
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildCategoriesItem(DataModel? model) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model!.image!),
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
          width: 100.0,
          color: Colors.black.withOpacity(0.6),
          child: Text(
            model.name!,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
Widget buildGridProduct(ProdcutModel model, context) => Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(
                  model.image ?? '',
                ),
                width: double.infinity,
                height: 200.0,
              ),
              if (model.discount != 0)
                Container(
                  color: defaultColor,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'discont'.toUpperCase(),
                    style: TextStyle(fontSize: 10.0, color: Colors.white),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price!.round()}\$',
                      style: const TextStyle(
                          fontSize: 12.0, height: 1.3, color: defaultColor),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice!.round()}\$',
                        style: const TextStyle(
                            fontSize: 12.0,
                            height: 1.3,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          print(model.id.toString());
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        padding: EdgeInsets.zero,
                        icon: Icon(ShopCubit.get(context).favorits[model.id]!
                            ? Icons.favorite
                            : Icons.favorite_border_outlined))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );

Widget buildFavoritItem(ProductsData ?model,context) => Padding(
      padding: const EdgeInsets.all(15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        child: SizedBox(
          height: 150.0,
          width: 150.0,
          child: Dismissible(
            background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        padding: EdgeInsets.only(right: 20),
      ),
      direction: DismissDirection.endToStart,
      
       onDismissed: (direction) {
         //Duration(milliseconds: 200);
         ShopCubit.get(context).getdismissed(model!.id);
         
      },
            key: UniqueKey(),
            child: Card(
              elevation: 3.0,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Image(
                          image: NetworkImage(
                             model!.image!.toString()),
                          fit: BoxFit.cover,
                          height: 120.0,
                          width: 120.0,
                        ),
                         if (model.discount != 0)
                        Container(
                          color: defaultColor,
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            'discont'.toUpperCase(),
                            style: TextStyle(fontSize: 10.0, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 15.0,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(model.name!,maxLines: 3,),
                          Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                model.price.toString(),
                                style: TextStyle(
                                  color: defaultColor,
                                  fontSize: 12.0,
                                  height: 1.3,
                                ),
                              ),
                              Spacer(),
                              if (model.discount != 0)
                              Text(
                                model.oldPrice.toString(),
                                style: TextStyle(
                                    fontSize: 12.0,
                                    height: 1.3,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough),
                              ),
          
                              IconButton(
                          onPressed: () {
                            print(model.id.toString());
                            ShopCubit.get(context).changeFavorites(model.id);
                          },
                          padding: EdgeInsets.zero,
                          icon: Icon(ShopCubit.get(context).favorits[model.id]!
                              ? Icons.favorite
                              : Icons.favorite_border_outlined))
                            ],
                          ),
                        ],
                      ),
                    ),
                   
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );



Widget buildSearchItem(model,context) => Padding(
      padding: const EdgeInsets.all(15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        child: SizedBox(
          height: 170.0,
          width: 220.0,
          child: Card(
            elevation: 3.0,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Image(
                        image: NetworkImage(
                           model!.image!.toString()),
                        
                        height: 120.0,
                        width: 120.0,
                      ),
                       if (model.discount != 0)
                      Container(
                        color: defaultColor,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          'discont'.toUpperCase(),
                          style: TextStyle(fontSize: 10.0, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 15.0,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(model.name!,maxLines: 3,),
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              model.price.toString(),
                              style: TextStyle(
                                color: defaultColor,
                                fontSize: 12.0,
                                height: 1.3,
                              ),
                            ),
                           
          
                            IconButton(
                        onPressed: () {
                          print(model.id.toString());
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        padding: EdgeInsets.zero,
                        icon: Icon(ShopCubit.get(context).favorits[model.id]!
                            ? Icons.favorite
                            : Icons.favorite_border_outlined))
                          ],
                        ),
                      ],
                    ),
                  ),
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );    
