import 'package:facebook_light/blocs/app/app_cubit.dart';
import 'package:facebook_light/components/buttons.dart';
import 'package:facebook_light/src/constants.dart';
import 'package:facebook_light/src/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPostView extends StatelessWidget {

  var textController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener:(context,state){} ,
      builder: (context,state){
        var cubit=AppCubit.get(context);
      return Scaffold(
        appBar:AppBar(
          titleSpacing: 0.0,
          title: Text('Create Post'),
          actions: [
            DefaultTextButton(
              action: () {
                if(cubit.postImage==null)
                  {
                    cubit.createPost(text: textController.text,dateTime: DateTime.now().toString() );
                  }
                else {
                  cubit.uploadPostImage(text: textController.text,dateTime: DateTime.now().toString(),);
                }
              },
              text: 'Post',
            ),
          ],
        ),

        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              if(state is AppCreatePostLoadingState)
              LinearProgressIndicator(),
              if(state is AppCreatePostLoadingState)
              SizedBox(height: 10,),
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                        'https://image.freepik.com/free-photo/man-filming-with-professional-camera_23-2149066324.jpg'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: Text(
                        'Aiman Ismail',
                        style: TextStyle(height: 1.4),
                      )),
                ],
              ),
              Expanded(
                child: TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                      hintText:'what is on your mind, Aiman?',
                    border: InputBorder.none
                  ),
                ),
              ),


              SizedBox(height: 20,),

              if(cubit.postImage!=null)
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                          image:FileImage(cubit.postImage),
                          fit: BoxFit.cover),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      cubit.removePostImage();
                    },
                    icon: CircleAvatar(
                      radius: 20,
                      child: Icon(
                        Icons.close,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(onPressed: (){
                      cubit.getPostImage();
                    }, child: Row(
                      children: [
                        Icon(
                          IconBroken.Image
                        ),
                        SizedBox(width: 5,),
                        Text('add photo')
                      ],
                    )),
                  ),
                  Expanded(
                    child: TextButton(onPressed: (){}, child: Text('# tags')),
                  ),

                ],
              )
            ],
          ),
        ),
      );
      },

    );
  }
}
