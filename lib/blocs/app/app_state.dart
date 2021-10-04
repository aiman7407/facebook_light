part of 'app_cubit.dart';

@immutable
abstract class AppState {}

///initial
class AppInitialState extends AppState {}

///get user data states
class AppGetUserDataSuccessState extends AppState {}
class AppGetUserDataLoadingState extends AppState {}
class AppGetUserDataErrorState extends AppState {
  final error;

  AppGetUserDataErrorState({this.error});
}


/// change bottom nav
///
class AppChangeBottomNavState extends AppState {}
class AppNewPostsState extends AppState {}


/// Image picker

class AppProfileImagePickedSuccessState extends AppState {}
class AppProfileImagePickedErrorState extends AppState {}


class AppProfileCoverImagePickedSuccessState extends AppState {}
class AppProfileCoverImagePickedErrorState extends AppState {}

///upload images



class AppUploadProfileImageSuccessState extends AppState {}
class AppUploadProfileImageErrorState extends AppState {}


class AppProfileUploadCoverImageSuccessState extends AppState {}
class AppProfileUploadCoverImageErrorState extends AppState {}

class AppUserUpdateLoadingState extends AppState {}
class AppUserUpdateErrorState extends AppState {}


/// create posts
class AppCreatePostSuccessState extends AppState {}
class AppCreatePostLoadingState extends AppState {}
class AppCreatePostErrorState extends AppState {}


class AppPostImagePickedSuccessState extends AppState {}
class AppPostImagePickedErrorState extends AppState {}

class AppRemoveImageState extends AppState {}


/// get posts
///


class AppGetPostsSuccessState extends AppState {}
class AppGetPostsLoadingState extends AppState {}
class AppGetPostsErrorState extends AppState {
final String error;

AppGetPostsErrorState({this.error});
}
/// like posts
///
class AppLikePostsSuccessState extends AppState {}

class AppLikePostsErrorState extends AppState {
  final String error;

  AppLikePostsErrorState({this.error});
}

/// get all users
///
class AppGetAllUsersDataSuccessState extends AppState {}
class AppGetAllUsersDataLoadingState extends AppState {}
class AppGetAllUsersDataErrorState extends AppState {
  final error;

  AppGetAllUsersDataErrorState({this.error});
}