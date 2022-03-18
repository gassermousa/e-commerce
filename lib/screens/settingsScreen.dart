import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/const/colors.dart';
import 'package:shop_app/const/constant.dart';
import 'package:shop_app/const/formfield.dart';
import 'package:shop_app/const/toast.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/shop_app/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/cubit/states.dart';

class SettingsSceen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();

  var nameTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var phoneTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
      if (state is ShopLoginSuccessState) {
        nameTextController.clear();
        emailTextController.clear();
        phoneTextController.clear();
      }
      if (state is ShopUpDateUserDataSuccessState) {
        if (state.loginModel!.status == true) {
          showToast(message: state.loginModel!.message!, color: successedToast);
        }
      }
    }, builder: (context, state) {
      var model = ShopCubit.get(context).modelData;
      nameTextController.text = model!.data!.name!;
      emailTextController.text = model.data!.email!;
      phoneTextController.text = model.data!.phone!;
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              if (state is ShopUpDateUserDataLoadingState)
                LinearProgressIndicator(),
              SizedBox(
                height: 15.0,
              ),
              defaultFormFiled(
                  controller: nameTextController,
                  action: TextInputAction.next,
                  type: TextInputType.name,
                  validate: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'please enter email address';
                    }
                    return null;
                  },
                  lable: 'Name',
                  prefixIcon: Icons.email_outlined),
              SizedBox(
                height: 15.0,
              ),
              defaultFormFiled(
                  controller: emailTextController,
                  action: TextInputAction.next,
                  type: TextInputType.name,
                  validate: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'please enter your name ';
                    }
                    return null;
                  },
                  lable: 'Email Address',
                  prefixIcon: Icons.person),
              SizedBox(
                height: 15.0,
              ),
              defaultFormFiled(
                  controller: phoneTextController,
                  action: TextInputAction.done,
                  type: TextInputType.phone,
                  validate: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'please enter your phone';
                    }
                    return null;
                  },
                  lable: 'Phone',
                  prefixIcon: Icons.phone),
              SizedBox(
                height: 30.0,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: defaultColor,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: MaterialButton(
                    child: Text(
                      'update'.toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        ShopCubit.get(context).upDtaeUserData(
                            name: nameTextController.text,
                            email: emailTextController.text,
                            phone: phoneTextController.text);
                      }
                    }),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: defaultColor,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: MaterialButton(
                    child: Text(
                      'logout'.toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      logOut(context);
                      
                      nameTextController.clear();
                      emailTextController.clear();
                      phoneTextController.clear();
                    }),
              ),
            ],
          ),
        ),
      );
    });
  }
}
