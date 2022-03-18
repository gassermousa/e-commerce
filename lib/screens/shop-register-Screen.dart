import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/const/colors.dart';
import 'package:shop_app/const/constant.dart';
import 'package:shop_app/const/formfield.dart';
import 'package:shop_app/const/navigator.dart';
import 'package:shop_app/const/toast.dart';

import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/network/local/cach_helper.dart';
import 'package:shop_app/screens/shop_home.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var paswordcontroller = TextEditingController();
  var phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCUbit(),
      child: BlocConsumer<ShopRegisterCUbit, ShopRegisterState>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.RegisterModel!.status == true) {
              showToast(
                  message: state.RegisterModel!.message!, color: successedToast);
                  CacheHelper.savedata(key: 'token', value: state.RegisterModel!.data!.token).then((value) => {
                    token= state.RegisterModel!.data!.token!,
                    navigateToAndFinish(context, ShopHomeScreen()),
                  });
            } else {
              showToast(
                  message: state.RegisterModel!.message!, color: warningToast);
            }
          }
        },
        builder: (context, state) => Scaffold(
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
                        'REGISTER',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Register Now To Browse Our Hot Offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultFormFiled(
                          controller: namecontroller,
                          action: TextInputAction.next,
                          type: TextInputType.name,
                          validate: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                          lable: 'name',
                          prefixIcon: Icons.person),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormFiled(
                          controller: emailcontroller,
                          action: TextInputAction.next,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                          lable: 'Email',
                          prefixIcon: Icons.email_outlined),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormFiled(
                          controller: paswordcontroller,
                          type: TextInputType.visiblePassword,
                          suffix: ShopRegisterCUbit.get(context).isPassword
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
                          scureText: ShopRegisterCUbit.get(context).isPassword,
                          suffixPressed: () {
                            ShopRegisterCUbit.get(context).changpassworedIcon();
                          },
                          prefixIcon: Icons.lock_outline),
                           SizedBox(
                        height: 15.0,
                      ),
                      defaultFormFiled(
                          controller: phonecontroller,
                          action: TextInputAction.done,
                          type: TextInputType.phone,
                          validate: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'please enter your phone';
                            }
                            return null;
                          },
                          lable: 'phone',
                          prefixIcon: Icons.phone),
                      SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: defaultColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0))),
                                child: MaterialButton(
                                    child: Text(
                                      'register'.toUpperCase(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      if (formkey.currentState!.validate()) {
                                        ShopRegisterCUbit.get(context)
                                            .userRegister(
                                                name: namecontroller.text,
                                                email: emailcontroller.text,
                                                phone: phonecontroller.text,
                                                password:
                                                    paswordcontroller.text);
                                      }
                                    }),
                              ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator())),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
