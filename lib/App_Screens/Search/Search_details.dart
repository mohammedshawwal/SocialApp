import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pix/App_Screens/profile_details/profile.dart';
import 'package:shop_pix/models/CreateUser_model.dart';
import '../../APP_Cubit/cubit.dart';
import '../../APP_Cubit/states.dart';
import '../editProfile_Screen/Edit_Profile.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialAppCubit.get(context);
  CreateUserModel model =CreateUserModel();
        return Scaffold(
          appBar: AppBar(
            title: Text('Search'),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'Search by name',
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    cubit.searchUsers(value.trim());
                  },
                ),
              ),
              if (state is SocialSearchLoadingState)
                LinearProgressIndicator(),
              Expanded(
                child: InkWell(
                  child: ListView.builder(
                    itemCount: cubit.searchResults.length,
                    itemBuilder: (context, index) {
                      var user = cubit.searchResults[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.image ?? ''),
                        ),
                        title: Text(user.name ?? ''),
                        subtitle: Text(user.bio ?? ''),
                      );
                    },
                  ),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileDetailsScreen(userId: model.uId ?? ''),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
