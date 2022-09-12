import 'package:social_app_firebase/features/features_exports.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postCubit = BlocProvider.of<PostCubit>(context);
    final userCubit = BlocProvider.of<UserCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: BlocBuilder<PostCubit, PostState>(
              builder: (context, state) => TextButton(
                onPressed: state is UploadPostImageLoading
                    ? null
                    : () => postCubit
                        .createNewPost(context),
                child: const Text(
                  'Post',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleImage(
                        text: '${userCubit.userModel?.image.toString()}'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('${userCubit.userModel?.name.toString()}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              const HorizontalSpace(1),
                              const Icon(Icons.check_circle),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const VerticalSpace(2),
                Expanded(
                  child: CustomTextFormField(
                      hintText: 'What is on your mind ...',
                      border: InputBorder.none,
                      controller: postCubit.newPostController),
                ),
                Column(
                  children: [
                    if (postCubit.postImageFile != null)
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.memory(
                            postCubit.postImageFile!,
                            height: context.heightInPercent(25),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          state is UploadPostImageLoading
                              ? const CircularProgressIndicator()
                              : CircleAvatar(
                                  child: IconButton(
                                      onPressed: postCubit.clearImage,
                                      icon: const Icon(Icons.close))),
                        ],
                      ),
                  ],
                ),
                const VerticalSpace(1),
                Row(
                  children: [
                    Expanded(
                      child: IconTextButton(
                        onTap: () => postCubit.pickPostImage(),
                        icon: IconBroken.image,
                        text: 'add photo',
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {}, child: const Text('# tags')),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
