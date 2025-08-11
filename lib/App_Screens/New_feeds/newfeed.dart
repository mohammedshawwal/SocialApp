import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pix/App_Screens/profile_details/profile.dart';
import '../../APP_Cubit/cubit.dart';
import '../../APP_Cubit/states.dart';
import '../../models/CreatePost_model.dart';

class NewFeed extends StatelessWidget {
  final commentController = TextEditingController();
  late final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        CreatePostModel model=CreatePostModel();
        return Scaffold(
          backgroundColor: Colors.grey[200],
          body: ListView(
            children: [
              // Banner
              Card(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 1,
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        InkWell(
                          child: CircleAvatar(
                            radius: 16,
                            backgroundImage: SocialAppCubit.get(context).model?.image != null
                                ? NetworkImage(SocialAppCubit.get(context).model!.image!)
                                : AssetImage('assets/default.png') as ImageProvider,
                          ),
                          onTap: ()
                          {
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (context)=>ProfileDetailsScreen(userId: model.uId??'' )));
                          },
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: TextFormField(
                            controller: commentController,
                            decoration: InputDecoration(
                              hintText: 'what in yor mind?',
                              hintStyle: TextStyle(fontSize: 14,
                                  ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                              isDense: true,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0,),
                        IconButton(onPressed: (){}, icon: Icon(Icons.image))
                      ],
                    ),
                  ),
              ),


              // Posts
              ...SocialAppCubit.get(context).posts.map(
                    (post) => _buildPostCard(post, context),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPostCard(CreatePostModel model, BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                InkWell(

                  child: CircleAvatar(
                    radius: 22,
                    backgroundImage: model.image != null && model.image!.isNotEmpty
                        ? NetworkImage(model.image!)
                        : AssetImage('assets/default.png') as ImageProvider,
                  ),
                  onTap: ()
                  {
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context)=>ProfileDetailsScreen(userId: model.uId??'' )));
                  },
                ),
                SizedBox(width: 8),


                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      child: Row(
                        children: [
                          Text(
                            model.name ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 16,
                          ),
                        ],
                      ),
                      onTap: ()
                      {
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (context)=>ProfileDetailsScreen(userId: model.uId??'' )));
                      },
                    ),
                    SizedBox(height: 3),
                 if(model.dateTime!=null)
                    Text(
                      '${model.dateTime}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),


          // Post text
          if (model.Text != null && model.Text!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(model.Text!),
            ),

          // Post image
          if (model.postImage != null && model.postImage!.isNotEmpty)
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Image(
                image: model.postImage!.startsWith('http')
                    ? NetworkImage(model.postImage!)
                    : AssetImage(model.postImage!) as ImageProvider,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),

          // Likes and comments count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                Icon(Icons.thumb_up, size: 16, color: Colors.blue),
                SizedBox(width: 4),
                Text('1.2K', style: TextStyle(fontSize: 13)),
                Spacer(),
                Text('120 Comments', style: TextStyle(fontSize: 13)),
              ],
            ),
          ),
          Divider(height: 1),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActionButton(Icons.thumb_up_alt_outlined, 'Like', Colors.blue),
              _buildActionButton(Icons.comment_outlined, 'Comment', Colors.green),
            ],
          ),
          Divider(height: 1),

          // Comment field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: SocialAppCubit.get(context).model?.image != null
                      ? NetworkImage(SocialAppCubit.get(context).model!.image!)
                      : AssetImage('assets/default.png') as ImageProvider,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: 'Write a comment...',
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color activeColor) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 18, color: Colors.grey[700]),
            SizedBox(width: 4),
            Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
          ],
        ),
      ),
      onHover: (hovering) {

      },
    );
  }
}
