import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shop_pix/App_Screens/Chats/Chats.dart';
import 'package:shop_pix/App_Screens/New_Post/New_post.dart';
import '../APP_Cubit/cubit.dart';
import '../APP_Cubit/states.dart';
import '../App_Screens/Search/Search_details.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      SocialAppCubit.get(context).getUserData();
    });
  }
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialAppCubit, SocialAppStates>(
        listener: (context, state) {
          if (state is AddNewPostState) {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => NewPostScreen()));
          }
        },
        builder: (context, state) {
          var cubit = SocialAppCubit.get(context);
          if (cubit.model == null) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );


          }
          return Scaffold(

              bottomNavigationBar: BottomNavigationBar(
                elevation: 0,
                  type: BottomNavigationBarType.fixed,

                  currentIndex: cubit.currentIndex,
                  onTap: (index)
                  {
                    cubit.changeBottomNav(index);
                  },
                  items:
                  [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_filled),
                      label: 'home',
                    ),

                    BottomNavigationBarItem(
                      icon: Icon(Icons.post_add),
                      label: 'Post',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.chat),
                      label: 'Chats',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'Settings',
                    ),
                  ]
              ),

            body: cubit.Screens[cubit.currentIndex]
          );

        },

    );
  }
}
