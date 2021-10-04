import 'package:facebook_light/components/custom_toast.dart';
import 'package:facebook_light/service/cache/cache_helper.dart';
import 'package:facebook_light/service/cache/cache_keys.dart';
import 'package:facebook_light/views/auth/login_view.dart';
import 'package:flutter/material.dart';


const kDefaultColor = Colors.blue;


void navigateTo({context, screen}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

void navigateAndFinish({context, screen}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => screen,
    ),
    (route) => false,
  );
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); //800 is size of each chunck
  pattern.allMatches(text).forEach((match) {
    print(match.group(0));
  });
}

void signOut(context)
{

  showToast(
      msg:' hahahhahah', toastStates: ToastStates.ERROR);
  CacheHelper.removeData(key: CACHE_KEY_USER_ID).
  then((value) {
    if(value)
      navigateAndFinish(screen: LoginView(),context:context );
  });

}