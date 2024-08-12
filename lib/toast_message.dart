import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/utils/color_constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
 class ToastMessage{
   static void showError(String error) async {
    await Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: ColorConstants().blackColor ,
        textColor: ColorConstants().whiteColor,
        fontSize: 16.0);
  }
}