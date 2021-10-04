import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_light/models/user_model.dart';
import 'package:facebook_light/service/network/dio_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  // ShopLoginModel loginModel;

  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(RegisterLoadingState());

    print(name + email + password + phone);

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.toString());
      print('بيطبع هنا عادي');
      //print(value.credential.token);
      print(value.user.email);
      print(value.user.uid);
      createUser(
          phone: phone, userId: value.user.uid, name: name, email: email);
      emit(RegisterSuccessState());
      print('*مش بيطبع هنا يصلاح *');
    }).catchError((error) {
      emit(RegisterErrorState(error: error));
    });
  }

  void createUser({
    @required String name,
    @required String email,
    @required String phone,
    @required String userId,
  }) {
    emit(RegisterCreateUserLoadingState());
    ///create userModel with default values
    UserModel userModel = UserModel(
        email: email,
        name: name,
        bio: 'write your bio ...',
        userId: userId,
        phone: phone,
        coverImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRO8ipAfBflFoYhZGrevb_XLAXuPvOB1SkCg&usqp=CAU',
        image: 'https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-portrait-176256935.jpg',
        isEmailVerified: false);
    FirebaseFirestore.instance
        .collection('users')

        /// add name + email is optional as it saved as doc id only
        .doc(userId)
        .set(userModel.toMap())
        .then((value) {
      emit(RegisterCreateUserSuccessState(userId: userId));
    }).catchError((error) {
      emit(RegisterCreateUserErrorState());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
