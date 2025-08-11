import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../APP_Cubit/cubit.dart';
import '../../APP_Cubit/states.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userModel = SocialAppCubit.get(context).model;
    if (userModel != null && nameController.text.isEmpty) {
      nameController.text = userModel.name ?? '';
      bioController.text = userModel.bio ?? '';
      phoneController.text = userModel.phone ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {
        if (state is UpdateCoverImageSuccessState) {
          Navigator.pop(context); // يقفل الصفحة بعد نجاح التحديث
        }
      },
      builder: (context, state) {
        final cubit = SocialAppCubit.get(context);
        final userModel = cubit.model;
        final profileImage = cubit.profileImage;
        final coverImage = cubit.coverImage;

        if (userModel == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: const Text('Edit Profile'),
                actions: [
                  TextButton(
                    onPressed: () {
                      cubit.updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                      );
                    },
                    child: const Text('Update'),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 210,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                    height: 160,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6),
                                      ),
                                      image: DecorationImage(
                                        image: coverImage == null
                                            ? NetworkImage(userModel.cover ?? '')
                                            : FileImage(coverImage) as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const CircleAvatar(
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        size: 20,
                                      ),
                                    ),
                                    onPressed: () {
                                      cubit.getCoverImage();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            CircleAvatar(
                              radius: 63,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundImage: profileImage == null
                                        ? NetworkImage(userModel.image ?? '')
                                        : FileImage(profileImage) as ImageProvider,
                                  ),
                                  IconButton(
                                    icon: const CircleAvatar(
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        size: 20,
                                      ),
                                    ),
                                    onPressed: () {
                                      cubit.getProfileImage();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          prefixIcon: const Icon(Icons.person),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: bioController,
                        decoration: InputDecoration(
                          labelText: 'Bio',
                          prefixIcon: const Icon(Icons.info_outline),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          prefixIcon: const Icon(Icons.phone),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),


            if (state is GetUserLoadingState)
              Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
          ],
        );
      },
    );
  }
}
