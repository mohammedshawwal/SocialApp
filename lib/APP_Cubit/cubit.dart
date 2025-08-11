import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shop_pix/APP_Cubit/states.dart';
import 'package:shop_pix/App_Screens/Chats/Chats.dart';
import 'package:shop_pix/App_Screens/New_feeds/newfeed.dart';
import 'package:shop_pix/App_Screens/Settings/Setting.dart';
import '../App_Screens/New_Post/New_post.dart';
import '../App_Screens/Users/Users.dart';
import '../models/CreatePost_model.dart';
import '../models/CreateUser_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialAppCubit extends Cubit<SocialAppStates> {
  SocialAppCubit() : super(SocialAppInitialState());

  static SocialAppCubit get(context) => BlocProvider.of(context);

  CreateUserModel? model;

  void getUserData() {
    emit(GetUserLoadingState());

    String? uId = FirebaseAuth.instance.currentUser?.uid;
    if (uId == null) {
      emit(GetUserErrorState("User ID is null. Please log in."));
      return;
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      if (value.exists) {
        model = CreateUserModel.fromJson(value.data()!);
        emit(GetUserSuccessState());
      } else {
        emit(GetUserErrorState("User data not found."));
      }
    }).catchError((error) {
      emit(GetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> Screens = [
    NewFeed(),
    Chats(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  void changeBottomNav(int index) {
    if (index == 2) {
      emit(AddNewPostState());
    } else {
      currentIndex = index;
      emit(BottomNavChangeState());
    }
  }

  List<String> Titels = [
    'home',
    'chats',
    'New Post',
    'Users',
    'Settings',
  ];

  File? profileImage;
  File? coverImage;
  File? postImage;

  Future<void> getProfileImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.single.path != null) {
      profileImage = File(result.files.single.path!);
      emit(GetProfileImageSuccessState());
    } else {
      emit(GetProfileImageErrorState());
    }
  }

  Future<void> getCoverImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.single.path != null) {
      coverImage = File(result.files.single.path!);
      emit(GetCoverImageSuccessState());
    } else {
      emit(GetCoverImageErrorState());
    }
  }

  Future<void> getPostImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.single.path != null) {
      postImage = File(result.files.single.path!);
      emit(PostImageSuccessState());
    } else {
      emit(PostImageErrorState());
    }
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
  }) async {
    emit(GetUserLoadingState());

    String? uId = model?.uId;
    if (uId == null) {
      emit(GetUserErrorState('error'));
      return;
    }

    String imageUrl = model?.image ?? '';
    String coverUrl = model?.cover ?? '';

    try {
      if (coverImage != null) {
        var coverRef = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('users/${Uri.file(coverImage!.path).pathSegments.last}');
        await coverRef.putFile(coverImage!);
        coverUrl = await coverRef.getDownloadURL();
      }

      if (profileImage != null) {
        var profileRef = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('users/${Uri.file(profileImage!.path).pathSegments.last}');
        await profileRef.putFile(profileImage!);
        imageUrl = await profileRef.getDownloadURL();
      }

      CreateUserModel updatedModel = CreateUserModel(
        name: name,
        phone: phone,
        email: model!.email,
        image: imageUrl,
        bio: bio,
        cover: coverUrl,
        uId: uId,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .update(updatedModel.toMap());

      getUserData();
      emit(UpdateCoverImageSuccessState());
    } catch (error) {
      emit(GetUserErrorState(error.toString()));
    }
  }

  void createPost({
    required String dateTime,
    required String text,

  }) {
    if (model == null) {
      emit(CreatePostError('User data not loaded'));
      return;
    }

    emit(CreatePostLoading());

    if (postImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
          .putFile(postImage!)
          .then((value) {
        value.ref.getDownloadURL().then((postImageUrl) {
          _createPostInFirestore(dateTime, text, postImageUrl);
        }).catchError((error) {
          emit(PostImageErrorState());
        });
      }).catchError((error) {
        emit(PostImageErrorState());
      });
    } else {
      _createPostInFirestore(dateTime, text, '');
    }
  }

  void _createPostInFirestore(String dateTime, String text, String postImageUrl) {
    CreatePostModel postModel = CreatePostModel(
      dateTime: dateTime,
      Text: text,
      postImage: postImageUrl,
      name: model!.name,
      image: model!.image,
      uId: model!.uId,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      postImage = postImage;
      emit(CreatePostSuccess());
    }).catchError((error) {
      emit(CreatePostError(error.toString()));
    });
  }

  List<CreatePostModel> posts = [];

  void getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((value) {
      posts.clear();
      value.docs.forEach((element) {
        posts.add(CreatePostModel.fromJson(element.data()));
      });
      emit(GetPostSuccessState());
    }, onError: (error) {
      emit(GetPostErrorState());
    });
  }

  List<CreateUserModel> allUsers = [];
  void getAllUsers() {
    allUsers = [];
    emit(SocialGetAllUsersLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
      for (var element in value.docs) {

        if (element.id != model!.uId) {
          allUsers.add(CreateUserModel.fromJson(element.data()));
        }
      }
      emit(SocialGetAllUsersSuccessState());
    }).catchError((error) {
      emit(SocialGetAllUsersErrorState(error.toString()));
    });
  }
  }

