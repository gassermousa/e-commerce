import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/const/formfield.dart';
import 'package:shop_app/const/widgets.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormFiled(
                        controller: controller,
                        action: TextInputAction.done,
                        type: TextInputType.text,
                        validate: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'please enter text';
                          }
                          return null;
                        },
                        onSubmit: (String text) {
                          SearchCubit.get(context).search(text);
                        },
                        lable: 'Search',
                        prefixIcon: Icons.search),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadinfState) LinearProgressIndicator(),
                    SizedBox(
                      height: 15.0,
                    ),
                    if(state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildSearchItem(
                              SearchCubit.get(context).model!.data!.data[index],
                              context),
                          separatorBuilder: (context, index) => Divider(
                                thickness: 1.0,
                              ),
                          itemCount:
                              SearchCubit.get(context).model!.data!.data.length),
                  ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
