import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/CreateUser_model.dart';
import 'register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required bool isEmailVarivied,
  }) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
        isEmailVarivied: isEmailVarivied,
      );
    }).catchError((error) {
      emit(RegisterError(error.toString()));
    });
  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required bool isEmailVarivied,
  }) {
    CreateUserModel model = CreateUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image: 'https://i.postimg.cc/qqtQN3zn/Whats-App-Image-2025-08-11-at-11-00-45.jpg',
      bio : 'write yor bio',
      cover: 'https://i.postimg.cc/FsyC30Tg/Whats-App-Image-2025-08-11-at-11-03-27.jpg',

    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccess());
    }).catchError((error) {
      emit(RegisterError(error.toString()));
    });
  }
}
