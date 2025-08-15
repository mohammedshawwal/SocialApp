import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pix/APP_Cubit/cubit.dart';
import 'package:shop_pix/APP_Cubit/states.dart';
import 'package:shop_pix/home_layout/home.dart';
import 'package:shop_pix/theme/dark_theme.dart';
import 'package:shop_pix/theme/light_theme.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'on_boarding/onBoardingScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  timeago.setLocaleMessages('ar', timeago.ArMessages());

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
      child: BlocConsumer<SocialAppCubit, SocialAppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = SocialAppCubit.get(context);
            return MaterialApp(
              title: 'Social App',
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode
                  .light,


              home: FirebaseAuth.instance.currentUser == null
                  ? OnBoardingScreen()
                  : HomeLayout(),
            );

          }
      ),
    );
  }
}
