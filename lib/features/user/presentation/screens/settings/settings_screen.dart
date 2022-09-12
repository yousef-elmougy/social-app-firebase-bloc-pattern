import 'package:social_app_firebase/features/features_exports.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<UserCubit>(context);
    return BlocBuilder<UserCubit, UserState>(
        builder: (context, state) => state is GetUserLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: context.heightInPercent(9.4)),
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.bottomCenter,
                        children: [
                          CacheImage(
                            image: '${userCubit.userModel?.cover}',
                            boxFit: BoxFit.cover,
                            height: context.heightInPercent(25),
                            width: double.infinity,
                          ),
                          Positioned(
                            top: context.heightInPercent(15),
                            child: CircleAvatar(
                              radius: context.heightInPercent(9.4),
                              backgroundColor: AppColors.white,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  '${userCubit.userModel?.image}',
                                ),
                                radius: context.heightInPercent(9),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text('${userCubit.userModel?.name}',
                        style: Theme.of(context).textTheme.titleLarge),
                    const VerticalSpace(1),
                    Text('${userCubit.userModel?.bio}',
                        style: Theme.of(context).textTheme.titleSmall),
                    const VerticalSpace(3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        CustomSettingsText(text: 'Posts', num: '100'),
                        CustomSettingsText(text: 'Followers', num: '10k'),
                        CustomSettingsText(text: 'Following', num: '500'),
                        CustomSettingsText(text: 'Likes', num: '50'),
                      ],
                    ),
                    const VerticalSpace(3),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () =>
                            Routes.settingsEditScreenScreen.goTo(context),
                        child: const Text('Edit Profile'),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          userCubit
                            .signOut(context);
                        },
                        child: const Text('Sign Out'),
                      ),
                    ),
                  ],
                ),
              ));
  }
}
