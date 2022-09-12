import 'icon_edit_image.dart';
import 'package:social_app_firebase/features/features_exports.dart';

class SettingsEditImages extends StatelessWidget {
  const SettingsEditImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<UserCubit>(context);
    return BlocBuilder<UserCubit, UserState>(
        builder: (context, state) => Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: context.heightInPercent(9.4)),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  userCubit.coverFile == null
                      ? CacheImage(
                          image: '${userCubit.userModel?.cover}',
                          boxFit: BoxFit.cover,
                          height: context.heightInPercent(25),
                          width: double.infinity,
                        )
                      : Image.memory(
                          userCubit.coverFile!,
                          height: context.heightInPercent(25),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                  IconEditImage(state: state, isCover: true),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: context.heightInPercent(9.4),
                  backgroundColor: AppColors.white,
                  child: CircleAvatar(
                    backgroundImage: userCubit.imageFile == null
                        ? NetworkImage('${userCubit.userModel?.image}')
                        : MemoryImage(userCubit.imageFile!)
                            as ImageProvider,
                    onBackgroundImageError: (exception, stackTrace) =>
                        ImageErrorListener,
                    radius: context.heightInPercent(9),
                  ),
                ),
                IconEditImage(state: state, isCover: false),
              ],
            ),
          ],
        ),
      );
  }
}
