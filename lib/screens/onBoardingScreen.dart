// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:shop_app/const/navigator.dart';
import 'package:shop_app/network/local/cach_helper.dart';
import 'package:shop_app/screens/loginScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.body,
    required this.title,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardcontroller = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboarder (1).png',
        body: 'MyBag ',
        title: 'WELCOME '),
    BoardingModel(
        image: 'assets/images/onboarder(2).png',
        body: 'MyBag ',
        title: 'Let\'s Go'),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: Text('SKIP'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardcontroller,
                itemBuilder: (context, index) =>
                    buildOnboardering(boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 40.0),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SmoothPageIndicator(
                  controller: boardcontroller,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.deepOrange,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardcontroller.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void submit() {
    CacheHelper.savedata(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateToAndFinish(context, LoginScreen());
      }
    });
  }
}

// ignore: camel_case_types

Widget buildOnboardering(BoardingModel model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    // ignore: prefer_const_literals_to_create_immutables
    children: [
      Expanded(child: Image(image: AssetImage('${model.image}'))),
      SizedBox(
        height: 30.0,
      ),
      Text(
        '${model.title}',
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        '${model.body}',
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 30.0,
      ),
    ],
  );
}
