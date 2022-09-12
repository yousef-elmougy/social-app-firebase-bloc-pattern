import '../../../features_exports.dart';
import '../../../user/data/models/user_model.dart';

class UsersChatItem extends StatelessWidget {
  const UsersChatItem({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return userModel.uId != AppStrings.uId
        ? InkWell(
            onTap: () => Routes.chatDetailsScreen.goTo(context,args: userModel),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: context.heightInPercent(12),
                child: Row(
                  children: [
                    CircleImage(text: userModel.image.toString(), radius: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(userModel.name.toString(),
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios, size: 30),
                  ],
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
