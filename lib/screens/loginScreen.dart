// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/const/colors.dart';
import 'package:shop_app/const/constant.dart';
import 'package:shop_app/const/formfield.dart';
import 'package:shop_app/const/navigator.dart';
import 'package:shop_app/const/toast.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/network/local/cach_helper.dart';
import 'package:shop_app/screens/shop-register-Screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shop_app/screens/shop_home.dart';

// ignore: use_key_in_widget_constructors

var formkey = GlobalKey<FormState>();
var emailcontroller = TextEditingController();
var paswordcontroller = TextEditingController();

// ignore: use_key_in_widget_constructors
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCUbit(),
      child: BlocConsumer<ShopLoginCUbit, ShoploginState>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel!.status == true) {
              showToast(
                  message: state.loginModel!.message!, color: successedToast);
                  CacheHelper.savedata(key: 'token', value: state.loginModel!.data!.token).then((value) => {
                    navigateToAndFinish(context, ShopHomeScreen()),
                    token= state.loginModel!.data!.token!
                  });
            } else {
              showToast(
                  message: state.loginModel!.message!, color: warningToast);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Login Now To Browse Our Hot Offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormFiled(
                            controller: emailcontroller,
                            action: TextInputAction.next,
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'please enter email address';
                              }
                              return null;
                            },
                            lable: 'Email Address',
                            prefixIcon: Icons.email_outlined),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormFiled(
                            controller: paswordcontroller,
                            type: TextInputType.visiblePassword,
                            suffix: ShopLoginCUbit.get(context).isPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            validate: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'please enter Password';
                              }
                              return null;
                            },
                            lable: 'Password',
                            action: TextInputAction.done,
                            scureText: ShopLoginCUbit.get(context).isPassword,
                            suffixPressed: () {
                              ShopLoginCUbit.get(context).changpassworedIcon();
                            },
                            prefixIcon: Icons.lock_outline),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                            condition: state is! ShopLoginLoadingState,
                            builder: (context) => Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: defaultColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                  child: MaterialButton(
                                      child: Text(
                                        'Login'.toUpperCase(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        if (formkey.currentState!.validate()) {
                                          ShopLoginCUbit.get(context).userLogin(
                                              email: emailcontroller.text,
                                              password: paswordcontroller.text);
                                              
                                        }
                                      }),
                                )
                            /*defaultButton(
                                text: 'login',
                                onpress: () {
                                  /*if(formkey.currentState==null){
                                    return null;
                                  }
                                  if (formkey.currentState!.validate()) {
                                  ShopLoginCUbit.get(context).userLogin(
                                      email: emailcontroller.text,
                                      password: paswordcontroller.text);
                                  }*/
                                },
                                isUpperCase: true,
                                radius: 5.0),*/
                            ,
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator())),
                        /*state is! ShopLoginLoadingState
                            ? defaultButton(
                                text: 'login',
                                onpress: () {
                                  print(emailcontroller.text);
                                  /*if (formkey.currentState!.validate()) {
                                    ShopLoginCUbit.get(context).userLogin(
                                        email: emailcontroller.text,
                                        password: paswordcontroller.text);
                                  }*/
                                },
                                isUpperCase: true,
                                radius: 5.0)
                            : Center(child: CircularProgressIndicator()),*/
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Dont have an account ?'),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, ShopRegisterScreen());
                                },
                                child: Text('register'.toUpperCase()))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
