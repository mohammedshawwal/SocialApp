import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pix/APP_Cubit/cubit.dart';
import 'package:shop_pix/APP_Cubit/states.dart';
import 'package:shop_pix/App_Screens/editProfile_Screen/Edit_Profile.dart';
import 'package:shop_pix/login/login.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialAppCubit.get(context);
        var userModel = cubit.model;

        return Scaffold(
          appBar: AppBar(
            title: Text('Settings'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // صورة الغلاف والبروفايل
                SizedBox(
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
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8)),
                            image: DecorationImage(
                              image: NetworkImage('${userModel!.cover}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 63,
                        backgroundColor:
                        Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage('${userModel.image}'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // اسم المستخدم والبروفايل
                Text(
                  '${userModel.name}',
                  style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${userModel.bio}',
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodySmall?.color),
                ),
                const SizedBox(height: 20),

                // الإحصائيات
                Row(
                  children: [
                    _buildStatItem('Posts', '100'),
                    _buildStatItem('Photos', '360'),
                    _buildStatItem('Followers', '10K'),
                    _buildStatItem('Following', '135'),
                  ],
                ),
                const SizedBox(height: 20),

                // أزرار تعديل البروفايل
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text('Add Photo'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(),
                          ),
                        );
                      },
                      child: const Icon(Icons.edit),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // زرار تغيير الثيم
                OutlinedButton.icon(
                  onPressed: () {
                    cubit.changeAppMode();
                  },
                  icon: const Icon(Icons.brightness_6),
                  label: const Text('Change Theme'),
                ),
                const SizedBox(height: 10),

                // زرار تسجيل الخروج
                OutlinedButton.icon(
                  onPressed: () {
                    cubit.signOut(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
