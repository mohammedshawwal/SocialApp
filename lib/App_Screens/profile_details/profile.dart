import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pix/APP_Cubit/cubit.dart';
import 'package:shop_pix/APP_Cubit/states.dart';

class ProfileDetailsScreen extends StatelessWidget {
  final String userId;

  const ProfileDetailsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialAppCubit.get(context);

        var userModel = userId == cubit.model!.uId
            ? cubit.model
            : cubit.allUsers.firstWhere((u) => u.uId == userId);

        return Scaffold(
          appBar: AppBar(
            title: Text(userModel!.name ?? ''),
          ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // صورة الغلاف + صورة البروفايل
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Cover
                      Container(
                        height: 230,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(userModel.cover ?? ''),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Profile Image
                      Positioned(
                        bottom: -60,
                        left: MediaQuery.of(context).size.width / 2 - 60,
                        child: CircleAvatar(
                          radius: 62,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 58,
                            backgroundImage:
                            NetworkImage(userModel.image ?? ''),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 70),

                  // الاسم + البايو
                  Text(
                    userModel.name ?? '',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    userModel.bio ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),

                  // أزرار تعديل أو إضافة ستوري (لو أنت)
                  if (userId == cubit.model!.uId)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[600],
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              icon: const Icon(Icons.add_circle_outline),
                              label: const Text("Add to Story"),
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.grey[400]!),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("Edit Profile"),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 20),
                  const Divider(thickness: 8, color: Color(0xFFF0F2F5)),

                  // الإحصائيات
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStat("Posts", "100"),
                      _buildStat("Followers", "10K"),
                      _buildStat("Following", "135"),
                    ],
                  ),

                  const SizedBox(height: 20),
                  const Divider(thickness: 8, color: Color(0xFFF0F2F5)),

                  // مثال بوست
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(userModel.image ?? ''),
                    ),
                    title: Text(
                      userModel.name ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text("My first post here!"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStat(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
      ],
    );
  }
}
