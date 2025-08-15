import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pix/App_Screens/ChatsDetailsScreen/Chat_Details.dart';
import 'package:shop_pix/models/CreateUser_model.dart';
import '../../APP_Cubit/cubit.dart';
import '../../APP_Cubit/states.dart';
import '../Search/Search_details.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialAppCubit.get(context);
        var users = cubit.allUsers;

        return Scaffold(
          appBar: AppBar(
            title:  Text('Chats'),


            actions: [

              IconButton(
                  onPressed: (){

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.search
                  )
              ),

            ],
          ),

          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildChatItem(users[index], context),
              separatorBuilder: (context, index) => Divider(),
              itemCount: users.length,
            ),
          ),
        );
      },
    );
  }

  Widget buildChatItem(CreateUserModel model, BuildContext context) =>
      InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ChatDetailsScreen(userModel: model),
        ),
      );
    },
    child: Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundImage: model.image != null && model.image!.isNotEmpty
              ? NetworkImage(model.image!)
              : AssetImage('assets/default.png') as ImageProvider,
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.name ?? '',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            if (model.bio != null)
              Text(
                model.bio!,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
          ],
        ),
      ],
    ),
  );
}
