import 'dart:developer';


import 'package:dio/dio.dart';
import 'package:flutter_shopping_app/services/dio/dio_interceptor.dart';

enum ApiRequestType { get, post }

class DioService {
  DioService._();
  static DioService instance = DioService._();
  factory DioService() => instance;

  final Dio dio = Dio()..interceptors.add(DioInterceptor());

  Future<Response> performRequest(
      String url,
      ApiRequestType method,
      Map<String, dynamic> headers,
      Map<String, dynamic> queryParameters,
      dynamic data) {
    try {
      var commonHeaders = {"Content-Type": "application/json", ...headers};
      var requestOptions = Options(
        method: method.name.toUpperCase(),
        headers: commonHeaders,
      );
      return dio.request(url,
          data: data.toString(),
          options: requestOptions);
    } on DioException  catch(ex){
        log(ex.runtimeType.toString());
        log(ex.toString());
        throw ex;
    }

     catch (ex) {
      rethrow; 
    }
  }
}
