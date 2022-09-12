import 'package:social_app_firebase/features/features_exports.dart';
import 'package:social_app_firebase/features/user/data/models/user_model.dart';

import '../cubit/chat_cubit.dart';
import '../widgets/message_item.dart';

class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    chatCubit.getMessage(receiverId: userModel.uId);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleImage(text: userModel.image.toString()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(userModel.name.toString(),
                  style: Theme.of(context).textTheme.titleLarge),
            ),
          ],
        ),
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: chatCubit.messages.length,
                    itemBuilder: (context, index) {
                      return MessageItem(
                          text: chatCubit.messages[index].text.toString(),
                          isMe: userModel.uId != chatCubit.messages[index].senderId);
                    },
                  ),
                ),
                TextField(
                  controller: chatCubit.messageController,
                  onSubmitted: (value) =>
                      chatCubit.sendMessage(receiverId: userModel.uId),
                  decoration: InputDecoration(
                    hintText: 'Add Message...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          chatCubit.sendMessage(receiverId: userModel.uId);
                        }),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
