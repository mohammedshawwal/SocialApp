import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pix/APP_Cubit/cubit.dart';
import 'package:shop_pix/APP_Cubit/states.dart';
import 'package:shop_pix/App_Screens/editProfile_Screen/Edit_Profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit,SocialAppStates>(
      listener: (BuildContext context, SocialAppStates state) {  },
      builder: (BuildContext context, SocialAppStates state) {
     var userModel =SocialAppCubit.get(context).model;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children:
          [
          Container(
            height: 210,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Container(
                    height: 160,
                    width: double.infinity,

                  decoration: BoxDecoration(

                    image: DecorationImage(
                        image:  NetworkImage('${userModel!.cover}'),
                          fit: BoxFit.cover,
                        ),

                  )
                  ),
                ),
                CircleAvatar(
                  radius: 63,
                  child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage('${userModel!.image}')
                  ),
                ),



                  ]
            ),
          ),
            SizedBox(height: 10,),
            Text('${userModel!.name}',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),

            ),
            Text('${userModel!.bio}',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),

            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children:
                [
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children:
                        [
                          Text('Post',
                            style: TextStyle(
                                fontSize: 15,

                            ),

                          ),
                          Text('100',
                            style: TextStyle(
                                fontSize: 25,

                            ),

                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children:
                        [
                          Text('Photos',
                            style: TextStyle(
                                fontSize: 15,
                            ),

                          ),
                          Text('360',
                            style: TextStyle(
                                fontSize: 15,
                            ),

                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children:
                        [
                          Text('Followers',
                            style: TextStyle(
                                fontSize: 15,
                            ),

                          ),
                          Text('10K',
                            style: TextStyle(
                                fontSize: 15,
                            ),

                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children:
                        [
                          Text('Following',
                            style: TextStyle(
                                fontSize: 15,
                            ),

                          ),
                          Text('135',
                            style: TextStyle(
                                fontSize: 15,
                            ),

                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                      onPressed: (){},
                      child: Text('Add photo')

                  ),
                ),
                SizedBox(width: 10,),
                OutlinedButton(
                    onPressed: ()
                    {
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context)=>EditProfileScreen()
                      )
                      );
                    },
                    child:Icon(Icons.edit)

                ),
              ],
            ),
          ],


        ),
      );
      },
    );
  }
}
