import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shopping_app/bloc/authentication/authentication_event.dart';
import 'package:flutter_shopping_app/bloc/authentication/authentication_state.dart';
import 'package:flutter_shopping_app/model/user.dart';
import 'package:flutter_shopping_app/repository/authentication_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationInitialState()) {
    on<UserLoginEvent>(_mapUserLoginState);
  }

  void _mapUserLoginState(
      UserLoginEvent event, Emitter<AuthenticationState> emit) async {
    emit(const AuthenticationLoadingState());
    try {
      await Future.delayed(const Duration(seconds: 1));
      UserModel userData = await AuthenticationRepository.instance
          .login(event.email, event.password);
      if (userData.accessToken.isNotEmpty) {
        emit(const AuthenticationLoadedState());
      } else {
        emit(const AuthenticationFailureState(messaage: "User Not Found"));
      }
    } on DioException catch (error) {
     
      emit(AuthenticationFailureState(messaage: error.message.toString()));
    } catch (error) {
      emit(const AuthenticationFailureState(messaage: "Something Went wrong"));
    }
  }
}
