import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable{

  const AuthenticationState();
  @override
  List<Object?> get props => [];

  
}

class AuthenticationInitialState extends AuthenticationState{
  const AuthenticationInitialState();
    
  }

class AuthenticationLoadingState extends AuthenticationState{
  const AuthenticationLoadingState();
    
  }
  class AuthenticationLoadedState extends AuthenticationState{
  const AuthenticationLoadedState();
    
  }
  class AuthenticationFailureState extends AuthenticationState{
    final String messaage;
   const  AuthenticationFailureState({required this.messaage});
  }