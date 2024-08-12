
import 'package:equatable/equatable.dart';

abstract class  AuthenticationEvent extends Equatable{
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}
class UserLoginEvent extends AuthenticationEvent{
  final String email;
  final String password;
 const   UserLoginEvent({required this.email, required this.password});
}