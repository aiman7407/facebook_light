import 'dart:io';

import 'package:facebook_light/blocs/app/app_cubit.dart';
import 'package:facebook_light/components/buttons.dart';
import 'package:facebook_light/components/text_field.dart';
import 'package:facebook_light/models/user_model.dart';
import 'package:facebook_light/src/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileView extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        UserModel userModel = cubit.userModel;
        nameController.text = userModel.name;
        bioController.text = userModel.bio;
        phoneController.text = userModel.phone;
        var profileImage = cubit.profileImage;
        var coverImage = cubit.coverImage;
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            title: Text('Edit Profile'),
            actions: [
              DefaultTextButton(
                action: () {
                  cubit.updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                },
                text: 'Update',
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // if (state is AppUserUpdateLoadingState)
                  //   LinearProgressIndicator(),
                  // if (state is AppUserUpdateLoadingState)
                  //   SizedBox(
                  //     height: 10,
                  //   ),
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(4),
                                    topLeft: Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                      image: coverImage == null
                                          ? NetworkImage(userModel.coverImage)
                                          : FileImage(coverImage),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit.getCoverImage();
                                },
                                icon: CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 20,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: profileImage == null
                                    ? NetworkImage(userModel.image)
                                    : FileImage(profileImage),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.getProfileImage();
                              },
                              icon: CircleAvatar(
                                radius: 20,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 20,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (cubit.profileImage != null || cubit.coverImage != null)
                    Row(
                      children: [
                        if (cubit.profileImage != null)
                          Expanded(
                              child: Column(
                            children: [
                              DefaultButton(
                                text: 'upload profile ',
                                action: () {
                                  cubit.uploadProfileImage(
                                      phone: phoneController.text,
                                      name: nameController.text,
                                      bio: bioController.text);
                                },
                                fontSize: 23.0,
                              ),
                              SizedBox(height: 5),
                              if(state is AppUserUpdateLoadingState)
                              LinearProgressIndicator(),
                              if(state is AppUserUpdateLoadingState)
                                SizedBox(height: 5),
                            ],
                          )),
                        SizedBox(
                          width: 5,
                        ),
                        if (cubit.coverImage != null)
                          Expanded(
                              child: Column(
                            children: [
                              DefaultButton(
                                text: 'upload Cover ',
                                action: () {
                                  cubit.uploadCoverImage(
                                      phone: phoneController.text,
                                      name: nameController.text,
                                      bio: bioController.text);
                                },
                                fontSize: 23.0,
                              ),
                              if(state is AppUserUpdateLoadingState)
                                LinearProgressIndicator(),
                              if(state is AppUserUpdateLoadingState)

                                SizedBox(height: 5),
                            ],
                          )),
                      ],
                    ),
                  if (cubit.profileImage != null || cubit.coverImage != null)
                    SizedBox(
                      height: 20,
                    ),
                  defaultFormField(
                      controller: nameController,
                      textInputType: TextInputType.name,
                      label: 'Name',
                      validate: (String text) {
                        if (text.isEmpty) {
                          return 'please add data';
                        }

                        return null;
                      },
                      prefixIcon: IconBroken.User),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                      controller: bioController,
                      textInputType: TextInputType.text,
                      label: 'bio',
                      validate: (String text) {
                        if (text.isEmpty) {
                          return 'please add data';
                        }

                        return null;
                      },
                      prefixIcon: IconBroken.Info_Circle),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      textInputType: TextInputType.phone,
                      label: 'Phone Number',
                      validate: (String text) {
                        if (text.isEmpty) {
                          return 'please add data';
                        }

                        return null;
                      },
                      prefixIcon: IconBroken.Call)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
