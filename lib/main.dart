import 'package:facebook_light/service/cache/cache_helper.dart';
import 'package:facebook_light/service/cache/cache_keys.dart';
import 'package:facebook_light/service/network/dio_helper.dart';
import 'package:facebook_light/src/app_root.dart';
import 'package:facebook_light/views/auth/login_view.dart';
import 'package:facebook_light/views/home_view.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  await Firebase.initializeApp();

  String userId = '';


  userId = CacheHelper.getData(key: CACHE_KEY_USER_ID);
  Widget startWidget;

  if (userId != null)
{
  startWidget=HomeView();
}
  else {
    startWidget=LoginView();
  }



  print(userId);
  runApp(AppRoot(startWidget: startWidget,));
}
