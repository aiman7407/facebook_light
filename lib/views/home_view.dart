import 'package:conditional_builder/conditional_builder.dart';
import 'package:facebook_light/blocs/app/app_cubit.dart';
import 'package:facebook_light/components/buttons.dart';
import 'package:facebook_light/components/custom_toast.dart';
import 'package:facebook_light/models/user_model.dart';
import 'package:facebook_light/src/constants.dart';
import 'package:facebook_light/src/icon_broken.dart';
import 'package:facebook_light/views/feed/new_posts_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if(state is AppNewPostsState )
          {
            navigateTo(context: context,screen: NewPostView());
          }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        UserModel userModel = cubit.userModel;
        print(FirebaseAuth.instance.currentUser.email);
        print(FirebaseAuth.instance.currentUser.emailVerified);
        return Scaffold(
          appBar: AppBar(
            title: Text('facebook light'),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Notification)),
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Search)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                  label: 'Home', icon: Icon(IconBroken.Home)),
              BottomNavigationBarItem(
                  label: 'Chat', icon: Icon(IconBroken.Chat)),
              BottomNavigationBarItem(
                  label: 'Posts', icon: Icon(IconBroken.Paper_Upload)),
              BottomNavigationBarItem(
                  label: 'Users', icon: Icon(IconBroken.Location)),
              BottomNavigationBarItem(
                  label: 'Setting', icon: Icon(IconBroken.Setting)),
            ],
          ),
        );
      },
    );
  }
}

//
// ConditionalBuilder(
// condition: cubit.userModel != null,
// fallback: (context) => Center(child: CircularProgressIndicator()),
// builder: (context) => Column(
// children: [
// if (!FirebaseAuth.instance.currentUser.emailVerified)
// Container(
// color: Colors.amber.withOpacity(0.6),
// child: Padding(
// padding: EdgeInsets.symmetric(horizontal: 20),
// child: Row(
// children: [
// Icon(Icons.info_outline),
// SizedBox(
// width: 15,
// ),
// Expanded(child: Text('Please Verfiy your email')),
// SizedBox(
// width: 20,
// ),
// DefaultTextButton(
// action: () {
// FirebaseAuth.instance.currentUser
//     .sendEmailVerification()
//     .then((value) {
// showToast(msg:'Please Check Your Email' ,toastStates:ToastStates.SUCCESS );
// })
//     .catchError((error) {});
// },
// text: 'Send Email',
// )
// ],
// ),
// ),
// )
// ],
// ),
// ),
