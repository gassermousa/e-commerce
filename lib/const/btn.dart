// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_app/const/colors.dart';

Widget defaultButton(
        {required String text,
        double? radius,
        double width = double.infinity,
        required Function onpress,
        bool? isUpperCase}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
          color: defaultColor,
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 0))),
      child: MaterialButton(
        onPressed: onpress(),
        child: Text(
          isUpperCase! ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

    Widget defaultTextBtn({
      required String text,
      required Function onpress
    })=>TextButton(onPressed: onpress(), child: Text(text.toUpperCase()));


    

