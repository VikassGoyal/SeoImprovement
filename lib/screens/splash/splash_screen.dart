import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/utils/color_constants.dart';
import 'package:flutter_shopping_app/utils/image_constants.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
   Future.delayed(
          const Duration(milliseconds: 500),(){
            context.go("/login");
          }
          ); 

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants().splashScreenBackgroundColor ,
      body:Center(
        child: Image.asset(ImageConstants().splashImage),
      )
    );
  }
}