abstract class SocialAppStates{

}
class SocialAppInitialState extends SocialAppStates{}

class SocialAppLoadingState extends SocialAppStates{}
class SocialAppSuccessState extends SocialAppStates{}
class SocialAppErrorState extends SocialAppStates{
  final String error;

  SocialAppErrorState(this.error);
}


class GetUserLoadingState extends SocialAppStates{}
class GetUserSuccessState extends SocialAppStates{}
class GetUserErrorState extends SocialAppStates{
  final String error;

  GetUserErrorState(this.error);
}


class BottomNavChangeState extends SocialAppStates{}

class AddNewPostState extends SocialAppStates{}

class GetProfileImageSuccessState extends SocialAppStates{}
class GetProfileImageErrorState extends SocialAppStates{}

class GetCoverImageSuccessState extends SocialAppStates{}
class GetCoverImageErrorState extends SocialAppStates{}

class UpdateCoverImageSuccessState extends SocialAppStates{}
class UpdateCoverImageErrorState extends SocialAppStates{}

class UpdateProfileImageSuccessState extends SocialAppStates{}
class UpdateProfileImageErrorState extends SocialAppStates{}

class UpdateUserLoadingState extends SocialAppStates {}
class UpdateUserSuccessState extends SocialAppStates{}
class UpdateUserErrorState extends SocialAppStates{
  final String error;

  UpdateUserErrorState(this.error);
}
class CreatePostLoading extends SocialAppStates{}
class CreatePostSuccess extends SocialAppStates{}
class CreatePostError extends SocialAppStates{
  final String error;

  CreatePostError(this.error);
}


class PostImageSuccessState extends SocialAppStates{}
class PostImageErrorState extends SocialAppStates{}

//post  states

class GetPostLoadingState extends SocialAppStates{}
class GetPostSuccessState extends SocialAppStates{}
class GetPostErrorState extends SocialAppStates{}

class SocialGetAllUsersLoadingState extends SocialAppStates{}
class SocialGetAllUsersSuccessState extends SocialAppStates{}

class SocialGetAllUsersErrorState extends SocialAppStates{
  final String error;

  SocialGetAllUsersErrorState(this.error);
}


class PostLikeSuccessState extends SocialAppStates{}

class PostLikeErrorState extends SocialAppStates{
  final String error;

  PostLikeErrorState(this.error);
}




class PostCommentSuccessState extends SocialAppStates{}

class PostCommentErrorState extends SocialAppStates{
  final String error;

  PostCommentErrorState(this.error);
}

