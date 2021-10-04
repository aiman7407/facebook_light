import 'package:conditional_builder/conditional_builder.dart';
import 'package:facebook_light/blocs/app/app_cubit.dart';
import 'package:facebook_light/models/user_model.dart';
import 'package:facebook_light/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        listener:(context,state){} ,
      builder:   (context,state){
          var cubit=AppCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.users.length>0,
            fallback: (context)=>Center(child: CircularProgressIndicator()),
            builder: (context)=>ListView.separated(
              physics: BouncingScrollPhysics(),
              separatorBuilder: (context,index){
                return Divider(height: 20,);
              },
              itemCount: cubit.users.length,
              itemBuilder: (context,index){
                return ChatItem(userModel: cubit.users[index],);
              },
            ),
          );
      }  ,
    );
  }
}


class ChatItem extends StatelessWidget {

  final UserModel userModel;


  ChatItem({this.userModel});


  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){},
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(
                  userModel.image
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              userModel.name,
              style: TextStyle(height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
