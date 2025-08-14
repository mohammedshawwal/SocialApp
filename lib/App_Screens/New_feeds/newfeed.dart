import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pix/App_Screens/New_Post/New_post.dart';
import 'package:shop_pix/App_Screens/profile_details/profile.dart';
import '../../APP_Cubit/cubit.dart';
import '../../APP_Cubit/states.dart';
import '../../models/CreatePost_model.dart';

class NewFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialAppCubit.get(context);

        return Scaffold(
          backgroundColor: Colors.grey[200],
          body: ListView(
            children: [
              // Banner
              Card(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      InkWell(
                        child: CircleAvatar(
                          radius: 16,
                          backgroundImage: cubit.model?.image != null
                              ? NetworkImage(cubit.model!.image!)
                              : AssetImage('assets/default.png')
                          as ImageProvider,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileDetailsScreen(
                                userId: cubit.model?.uId ?? '',
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: InkWell(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'What\'s on your mind?',
                              hintStyle: TextStyle(fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                              isDense: true,
                            ),
                            enabled: false,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewPostScreen()),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 10.0),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.image),
                      ),
                    ],
                  ),
                ),
              ),

              // Posts
              ...List.generate(
                cubit.posts.length,
                    (index) {
                  final post = cubit.posts[index];
                  final postId = cubit.postId[index];
                  return _buildPostCard(post, context, postId, index);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPostCard(
      CreatePostModel model, BuildContext context, String postId, index) {
    var cubit = SocialAppCubit.get(context);
    final likeCount = cubit.likes[postId] ?? 0;
    final commentCount = cubit.postComments[postId]?.length ?? 0;
    final commentController = TextEditingController();
    final isLiked = cubit.isLiked[postId] ?? false;
    cubit.getComments(postId);


    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProfileDetailsScreen(userId: model.uId ?? ''),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 22,
                    backgroundImage: model.image != null &&
                        model.image!.isNotEmpty
                        ? NetworkImage(model.image!)
                        : AssetImage('assets/default.png') as ImageProvider,
                  ),
                ),
                SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProfileDetailsScreen(userId: model.uId ?? ''),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model.name ?? '',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      if (model.dateTime != null)
                        Text(model.dateTime!,
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Post Text
          if (model.Text != null && model.Text!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(model.Text!),
            ),

          // Post Image
          if (model.postImage != null && model.postImage!.isNotEmpty)
            Image(
              image: NetworkImage(model.postImage!),
              fit: BoxFit.cover,
              width: double.infinity,
            ),

          // Like & Comments count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                Icon(Icons.thumb_up, size: 16, color: Colors.blue),
                SizedBox(width: 4),
                InkWell(
                  child: Text('$likeCount Likes'),
                  onTap: () {
                    _showLikersSheet(
                        context, cubit.postLikers[postId] ?? [], postId);
                  },
                ),
                Spacer(),
                InkWell(
                  child: Text('$commentCount Comments',
                      style: TextStyle(fontSize: 13)),
                  onTap: () {
                    _showCommentsSheet(
                        context, cubit.postComments[postId] ?? []);
                  },
                ),
              ],
            ),
          ),
          Divider(height: 1),

          // Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                child: _buildActionButton(
                  Icons.thumb_up_alt_outlined,
                  'Like',
                  iconColor: isLiked ? Colors.blue : Colors.grey[700],
                  textColor: isLiked ? Colors.blue : Colors.grey[700],
                ),
                onTap: () {
                  cubit.getLikes(postId);
                },
              ),
              InkWell(
                child: _buildActionButton(Icons.comment_outlined, 'Comment'),
                onTap: () {
                  cubit.getComments(postId);
                  _showCommentsSheet(
                    context,
                    (cubit.postComments[postId] ?? []) as List<Map<String, dynamic>>,
                  );                },
              ),
            ],
          ),
          Divider(height: 1),

          // Comment input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileDetailsScreen(
                          userId: cubit.model?.uId ?? '',
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 16,
                    backgroundImage: cubit.model?.image != null
                        ? NetworkImage(cubit.model!.image!)
                        : AssetImage('assets/default.png') as ImageProvider,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: 'Write a comment...',
                      border: InputBorder.none,
                      isDense: true,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send, color: Colors.blue),
                        onPressed: () {
                          if (commentController.text.trim().isNotEmpty) {
                            cubit.addComment(
                              postId: postId,
                              text: commentController.text.trim(),

                            );

                            cubit.getComments(postId);
                            commentController.clear();
                          }
                        },
                      ),
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

  Widget _buildActionButton(IconData icon, String label,
      {Color? iconColor, Color? textColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: iconColor ?? Colors.grey[700]),
          SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 14, color: textColor ?? Colors.grey[700])),
        ],
      ),
    );
  }

  void _showLikersSheet(BuildContext context, List likers, String postId) {
    var cubit = SocialAppCubit.get(context);
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      backgroundColor: Colors.white,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            height: 500,
            child: Column(
              children: [
                Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2))),
                SizedBox(height: 12),
                Expanded(
                  child: likers.isNotEmpty
                      ? ListView.separated(
                    itemCount: likers.length,
                    separatorBuilder: (_, __) => Divider(height: 1),
                    itemBuilder: (context, i) {
                      final user = likers[i];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProfileDetailsScreen(
                                      userId: user.uId ?? ''),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          backgroundImage: user.image != null &&
                              user.image!.isNotEmpty
                              ? NetworkImage(user.image!)
                              : AssetImage('assets/default.png')
                          as ImageProvider,
                        ),
                        title: Text(user.name ?? 'Unknown'),
                      );
                    },
                  )
                      : Center(child: Text("No likes yet")),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCommentsSheet(BuildContext context, List<Map<String, dynamic>> comments) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          height: 500,
          child: comments.isNotEmpty
              ? ListView.separated(
            itemCount: comments.length,
            separatorBuilder: (_, __) => Divider(height: 1),
            itemBuilder: (context, i) {
              final comment = comments[i];
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileDetailsScreen(
                        userId: comment['uId'] ?? '',
                      ),
                    ),
                  );
                },
                leading: CircleAvatar(
                  backgroundImage: (comment['image'] != null &&
                      comment['image'].toString().isNotEmpty)
                      ? NetworkImage(comment['image'])
                      : AssetImage('assets/default.png') as ImageProvider,
                ),
                title: Text(comment['name'] ?? 'Unknown'),
                subtitle: Text(comment['text'] ?? ''),
              );
            },
          )
              : Center(child: Text("No comments yet")),
        );
      },
    );
  }
}
