
import '../../../features_exports.dart';
import '../widgets/users_chat_item.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<UserCubit>(context);
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) =>
              userCubit.users[index].uId != AppStrings.uId
                  ? const Divider()
                  : const SizedBox(),
          itemCount: userCubit.users.length,
          itemBuilder: (context, index) =>
              UsersChatItem(userModel: userCubit.users[index]),
        );
      },
    );
  }
}
