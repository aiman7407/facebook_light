part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitialState extends LoginState {}
class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {

  final String userId;

  LoginSuccessState({this.userId});
}
class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState({this.error});
}

class LoginPasswordChangeIConState extends LoginState {}

