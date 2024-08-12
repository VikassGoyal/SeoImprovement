
import 'package:flutter_shopping_app/services/dio/dio_exception.dart';

import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
   
    super.onRequest(options, handler);
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
   
    super.onResponse(response, handler);
  }
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
       _handleError(err);
    super.onError(err, handler);
  }

  _handleError(DioException error){
    switch(error.type){
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
       throw TimeOutException(error.message.toString(), error.requestOptions);
      case DioExceptionType.badResponse:
      switch(error.response?.statusCode){
        case 400: 
        throw BadRequestException(error.message.toString(), error.requestOptions);
        case 401:
            throw UnauthorisedException(
              error.message.toString(),
              error.requestOptions,
            );
          case 403:
            throw UnauthorisedException(
              error.message.toString(),
              error.requestOptions,
            );
          case 404:
            throw FileNotFoundException(
              error.message.toString(),
              error.requestOptions,
            );
          case 500:
            throw InternalServerException(
              error.message.toString(),
              error.requestOptions,
            );
          case 502:
            throw BadGateWayException(
              error.message.toString(),
              error.requestOptions,
            );
          case 503:
            throw BadGateWayException(
              error.message.toString(),
              error.requestOptions,
            );
      }
      break;
      case DioExceptionType.unknown:
      throw ConnectionException(
          'Please check your network connection',
          error.requestOptions,
        );
        default:
        throw ConnectionException(
          'Please check your network connection',
          error.requestOptions,
        );
    }

  }
}
