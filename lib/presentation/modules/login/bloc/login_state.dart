import 'package:todolist/domain/entities/User.dart';

abstract class LoginState {}

class LoginInitial extends LoginState{}

class LoginLoading extends LoginState{}

class LoginSuccess extends LoginState {
  final User user;
  LoginSuccess(this.user);
}

class LoginFailure extends LoginState{
  final String message;
  LoginFailure(this.message);
}

