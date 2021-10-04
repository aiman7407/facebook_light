import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_light/models/post_model.dart';
import 'package:facebook_light/models/user_model.dart';
import 'package:facebook_light/service/cache/cache_helper.dart';
import 'package:facebook_light/service/cache/cache_keys.dart';
import 'package:facebook_light/views/feed/chat_view.dart';
import 'package:facebook_light/views/feed/feeds_view.dart';
import 'package:facebook_light/views/feed/new_posts_view.dart';
import 'package:facebook_light/views/feed/settings_view.dart';
import 'package:facebook_light/views/feed/users_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'app_state.dart';



// ignore: slash_for_doc_comments
/**

 * ? this how the cubit works
 * * bottom nav controller
 * *user data
 * *file picker
 * *firebase_storage
 * *create post
 * *get posts
 * * get users
**/



class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  /// bottom nav  side

  int currentIndex = 0;
  List<Widget> screens = [
    FeedView(),
    ChatView(),
    NewPostView(),
    UsersView(),
    SettingsView(),
  ];

  void changeBottomNav(int index) {
    if (index == 2) {
      emit(AppNewPostsState());
    } else {
      currentIndex = index;
      emit(AppChangeBottomNavState());
    }
  }

  /// user data side
  UserModel userModel;

  void getUserData() {
    emit(AppGetUserDataLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: CACHE_KEY_USER_ID))
        .get()
        .then((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data());
      emit(AppGetUserDataSuccessState());
    }).catchError((error) {
      emit(AppGetUserDataErrorState(error: error));
    });
  }

  /// file picker

  File profileImage;
  File coverImage;

  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(AppProfileImagePickedSuccessState());
    } else {
      emit(AppProfileImagePickedErrorState());
      print('no images');
    }
  }

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(AppProfileCoverImagePickedSuccessState());
    } else {
      emit(AppProfileCoverImagePickedErrorState());
      print('no images');
    }
  }

  /// firebase_storage

  void uploadProfileImage({String name, String bio, String phone}) {
    emit(AppUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //  emit(AppUploadProfileImageSuccessState());
        ///value has the url of image
        updateUser(phone: phone, name: name, bio: bio, profile: value);

        //print(value);
      }).catchError((error) {
        emit(AppUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(AppUploadProfileImageErrorState());
      print(error.toString());
    });
  }

  void uploadCoverImage({String name, String bio, String phone}) {
    emit(AppUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(AppUploadProfileImageSuccessState());
        updateUser(cover: value, bio: bio, name: name, phone: phone);
        print(value);
      }).catchError((error) {
        emit(AppProfileUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(AppProfileUploadCoverImageErrorState());
      print(error.toString());
    });
  }

  void updateUser(
      {String name, String bio, String phone, String cover, String profile}) {
    UserModel updatedUserModel = UserModel(
        name: name,
        bio: bio,
        phone: phone,
        email: userModel.email,
        coverImage: cover ?? userModel.coverImage,
        image: profile ?? userModel.image,
        userId: userModel.userId,
        isEmailVerified: false);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.userId)
        .update(updatedUserModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(AppUserUpdateErrorState());
    });
  }

  ///create post
  ///
  File postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(AppPostImagePickedSuccessState());
    } else {
      emit(AppPostImagePickedErrorState());
      print('no images');
    }
  }

  void uploadPostImage(
      {String name,
      String userId,
      String dateTime,
      String text,
      String image}) {
    emit(AppCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(text: text, postImage: value, dateTime: dateTime);
      }).catchError((error) {
        emit(AppCreatePostErrorState());
      });
    }).catchError((error) {
      emit(AppCreatePostErrorState());
      print(error.toString());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(AppRemoveImageState());
  }

  void createPost({
    @required String dateTime,
    @required String text,
    String postImage,
  }) {
    emit(AppCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel.name,
      image: userModel.image,
      userId: userModel.userId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(AppCreatePostSuccessState());
      // not the best practise
      posts = [];
      likes = [];
      getPosts();
    }).catchError((error) {
      emit(AppCreatePostErrorState());
    });
  }

  /// get posts part
  /// \
  ///

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          emit(AppGetPostsSuccessState());
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });
    }).catchError((error) {
      print(error.toString());
      emit(AppGetPostsErrorState(error: error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.userId)
        .set({
      'like': true,
    }).then((value) {
      emit(AppLikePostsSuccessState());
    }).catchError((error) {
      emit(AppLikePostsErrorState(error: error.toString()));
    });
  }

  /// get all users
  ///

  List<UserModel> users = [];

  void getUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel.userId)
            users.add(UserModel.fromJson(element.data()));
        });

        emit(AppGetAllUsersDataSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(AppGetAllUsersDataErrorState(error: error.toString()));
      });
  }
}
