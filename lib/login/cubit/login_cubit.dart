import 'package:flutter_bloc/flutter_bloc.dart';

import '../../consts/consts.dart';
import '../../remote/dio.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(LoginInitialState());
  static  LoginCubit get(context)=>BlocProvider.of(context);
  void userLogin({
    required String email,
    required String password,
  }) {
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      emit(LoginSuccess());
    }).catchError((error) {
      print('Login Error: ${error.toString()}');
      emit(LoginError(error.toString()));
    });
  }
}