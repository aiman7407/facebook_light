import 'package:facebook_light/blocs/app/app_cubit.dart';
import 'package:facebook_light/blocs/login/login_cubit.dart';
import 'package:facebook_light/src/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppRoot extends StatelessWidget {
  final Widget startWidget;

  AppRoot({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [


        BlocProvider(create: (BuildContext context) => LoginCubit()),
        BlocProvider(create: (BuildContext context) => AppCubit()..getUserData()..getPosts()..getUsers()),


      ],
      child: MaterialApp(
        theme: kLightTheme,
        darkTheme: kDarkTheme,
        home: startWidget,
      ),
    );
  }
}
