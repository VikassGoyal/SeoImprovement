import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_shopping_app/model/user.dart';
import 'package:flutter_shopping_app/services/dio/dio.dart';
import 'package:flutter_shopping_app/services/dio/dio_exception.dart';
import 'package:flutter_shopping_app/utils/app_constants.dart';

class AuthenticationRepository{
  AuthenticationRepository._();
  static AuthenticationRepository instance  = AuthenticationRepository._();
  factory AuthenticationRepository() => instance;

  Future<UserModel> login(String email , String password) async {

    try{
      final response =  await  DioService.instance.performRequest(AppConstants().baseUrl, ApiRequestType.post , {}, {},{"username": email, "password": password} );
      return UserModel.fromJson(response.data);

    }
     catch(ex){
      log("error check");
      if(ex is ConnectionException){
         log(ex.message);
      }
     
     
       throw ex;

     }
  }
}