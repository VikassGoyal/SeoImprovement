import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/utils/color_constants.dart';

class CommonButton extends StatelessWidget {
 final  Widget childWidget;
 final VoidCallback onTap;
  const  CommonButton({ required this.childWidget , required this.onTap , super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants().loginButton,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
                ),
                onPressed: onTap, child:   Center(
                child:  Padding(
                  padding: EdgeInsets.all(8.0),
                  child: childWidget,
                )));
  }
}