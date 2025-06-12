import 'package:flutter/material.dart';
import 'package:logic_practice/animation/controller/animation_controller.dart';
import 'package:logic_practice/animation/view/animation_home.dart';
import 'package:logic_practice/animation/view/second_screen.dart';
import 'package:logic_practice/matrix/controller/get_controller.dart';
import 'package:logic_practice/matrix/screens/color_matrix.dart';
import 'package:get/get.dart';

void main() {
  Get.put(MatrixController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: AnimationHome(),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: ()=> AnimationHome()),
        GetPage(name: "/second", page: ()=> SecondScreen(),customTransition: CustomFadeSlideTransition(),transitionDuration: Duration(milliseconds: 600))
      ],
      
      debugShowCheckedModeBanner: false,
    );
  }
}
