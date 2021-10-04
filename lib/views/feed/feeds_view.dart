import 'package:conditional_builder/conditional_builder.dart';
import 'package:facebook_light/blocs/app/app_cubit.dart';
import 'package:facebook_light/models/post_model.dart';
import 'package:facebook_light/src/constants.dart';
import 'package:facebook_light/src/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);


        return ConditionalBuilder(
          condition: cubit.posts.length>0,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.all(8),
                  elevation: 5,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage(
                            'https://image.freepik.com/free-photo/man-filming-with-professional-camera_23-2149066323.jpg'),
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Communicate With Your Friends ! ',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(color: Colors.white)),
                      )
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cubit.posts.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 8,
                    );
                  },
                  itemBuilder: (context, index) {
                    return PostItem(postModel: cubit.posts[index],index: index,);
                  },
                ),
                SizedBox(
                  height: 8,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class PostItem extends StatelessWidget {

  final PostModel postModel;
  final int  index;

  PostItem({this.postModel,this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 8),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                  postModel.image
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          postModel.name,
                          style: TextStyle(height: 1.4),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: kDefaultColor,
                          size: 16.0,
                        )
                      ],
                    ),
                    Text(
                      postModel.dateTime,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(height: 1.4),
                    ),
                  ],
                )),
                SizedBox(
                  width: 15,
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                    size: 16,
                  ),
                  onPressed: () {},
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                  width: double.infinity, height: 1, color: Colors.grey[300]),
            ),
            Text(
              postModel.text,
                style: Theme.of(context).textTheme.subtitle1),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 5),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: Container(
                        height: 25,
                        child: MaterialButton(
                            padding: EdgeInsets.zero,
                            minWidth: 1,
                            onPressed: () {},
                            child: Text(
                              '#softWare',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: kDefaultColor),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if(postModel.postImage!='')
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://image.freepik.com/free-photo/man-filming-with-professional-camera_23-2149066323.jpg'),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        AppCubit.get(context).likePost(AppCubit.get(context).postsId[index]);

                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              size: 16,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${AppCubit.get(context).likes[index]}',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              size: 16,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '0 comments',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                  width: double.infinity, height: 1, color: Colors.grey[300]),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18.0,
                          backgroundImage: NetworkImage(
                          AppCubit.get(context).userModel.image
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Write a Comment ...',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {

                  },
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Heart,
                        size: 16,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
