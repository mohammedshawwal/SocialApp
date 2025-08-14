import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pix/APP_Cubit/cubit.dart';
import 'package:shop_pix/APP_Cubit/states.dart';
import 'package:shop_pix/home_layout/home.dart';

import 'on_boarding/onBoardingScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
          SocialAppCubit()..getUserData()..getPosts(),
        ),
      ],
      child: MaterialApp(
        title: 'Social App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          // bottomNavigationBarTheme: BottomNavigationBarThemeData(
          //   backgroundColor: Colors.blue,
          //   elevation: 10,
          //   selectedItemColor: Colors.white,
          //   unselectedItemColor: Colors.white70,
          // ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.blue, fontWeight:FontWeight.bold,fontSize: 20),
            iconTheme: IconThemeData(color: Colors.blue),
            elevation: 0
          ),
        ),


        home: FirebaseAuth.instance.currentUser == null? OnBoardingScreen():HomeLayout(),
      ),
    );
  }
}
