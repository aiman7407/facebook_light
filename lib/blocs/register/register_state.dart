part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
//   final ShopLoginModel loginModel;
//
//   ShopRegisterSuccessState(this.loginModel);
// }
}

class RegisterErrorState extends RegisterState {
  final error;

  RegisterErrorState({this.error});
}

class ShopRegisterChangePasswordVisibilityState extends RegisterState {}

class RegisterCreateUserSuccessState extends RegisterState {
  final userId;

  RegisterCreateUserSuccessState({this.userId});
}

class RegisterCreateUserErrorState extends RegisterState {
  final error;

  RegisterCreateUserErrorState({this.error});
}

class RegisterCreateUserLoadingState extends RegisterState {}
