import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pix/APP_Cubit/cubit.dart';
import 'package:shop_pix/APP_Cubit/states.dart';
import '../../models/CreateUser_model.dart';
import '../../models/massegemodel.dart';

class ChatDetailsScreen extends StatefulWidget {
  final CreateUserModel userModel;

  ChatDetailsScreen({super.key, required this.userModel});

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}


class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  final TextEditingController messageController = TextEditingController();
  @override
void initState() {
    SocialAppCubit.get(context).getMassage(receiverId: widget.userModel.uId!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {

        return Scaffold(
          //backgroundColor: Colors.grey[200],
          appBar: AppBar(

            elevation: 1,
            titleSpacing: 0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(widget.userModel.image!),
                ),
                const SizedBox(width: 12),
                Text(
                  widget.userModel.name!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,

                  ),
                ),
              ],
            ),
            iconTheme: const IconThemeData(color: Colors.black87),
          ),
          body: ConditionalBuilder(
            condition: SocialAppCubit.get(context).messagesLoading,
            builder: (context) => Column(
              children: [
                Expanded(
                  child:SocialAppCubit.get(context).messages.isEmpty
                      ? Center(child: Text("Start Chat Now"))
                      : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(12),
                    itemBuilder: (context, index) {
                      var message = SocialAppCubit.get(context).messages[index];
                      if (SocialAppCubit.get(context).model!.uId ==
                          message.senderId
                      ) {
                        return buildMyMessage(message);
                      } else {
                        return buildMessage(message);
                      }
                    },
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 8),
                    itemCount: SocialAppCubit.get(context).messages.length,

                  ),
                ),
                buildMessageInput(context),
              ],
            ),
            fallback: (context) =>  Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }


  Widget buildMessage(MassageModel model) => Align(
    alignment: Alignment.centerLeft,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15).copyWith(
          topLeft: const Radius.circular(0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      child: Text(
       model.Text!,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    ),
  );

  // رسائل المرسل
  Widget buildMyMessage(MassageModel model) => Align(
    alignment: Alignment.centerRight,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blue[400],
        borderRadius: BorderRadius.circular(15).copyWith(
          topRight: const Radius.circular(0),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      child: Text(
        model.Text!,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    ),
  );

  Widget buildMessageInput(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(

      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 5,
          offset: const Offset(0, -2),
        ),
      ],
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextFormField(
              controller: messageController,
              decoration: const InputDecoration(
                hintText: 'اكتب رسالتك...',
                border: InputBorder.none,
                contentPadding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.blue,
          child: IconButton(
            onPressed: () {
              SocialAppCubit.get(context).sendMassage(
                receiverId: widget.userModel.uId!,
                dateTime: DateTime.now().toString(),
                text: messageController.text,
              );
              messageController.clear();
            },
            icon: const Icon(Icons.send, color: Colors.white, size: 20),
          ),
        ),
      ],
    ),
  );
}
