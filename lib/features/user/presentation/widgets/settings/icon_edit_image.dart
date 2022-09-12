import 'package:social_app_firebase/features/features_exports.dart';

class IconEditImage extends StatelessWidget {
  const IconEditImage({Key? key, required this.state, this.isCover})
      : super(key: key);

  final Object state;
  final bool? isCover;

  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<UserCubit>(context);
    return IconButton(
      onPressed: () => state is UploadImageLoading
          ? null
          : isCover == true
              ? userCubit
                  .pickCoverImage()
              : userCubit
                  .pickCircleImage(),
      icon: state is UploadImageLoading
          ? const Center(child: CircularProgressIndicator())
          : const CircleAvatar(
              child: Icon(IconBroken.camera),
            ),
    );
  }
}
