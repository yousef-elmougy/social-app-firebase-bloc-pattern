import 'package:social_app_firebase/features/features_exports.dart';
import 'package:social_app_firebase/features/post/presentation/widgets/home/wrap_text.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.postModel});

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<UserCubit>(context);
    final postCubit = BlocProvider.of<PostCubit>(context);

    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleImage(text: postModel.image),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(postModel.name.toString(),
                              style: Theme.of(context).textTheme.titleMedium),
                          const HorizontalSpace(1),
                          const Icon(Icons.check_circle),
                        ],
                      ),
                      Text('${postModel.dateTime}',
                          style: Theme.of(context).textTheme.titleSmall),
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                    icon: const Icon(Icons.more_horiz), onPressed: () {}),
              ],
            ),
            const VerticalSpace(1),
            const Divider(),
            const VerticalSpace(1),
            Text(postModel.text.toString(),
                style: Theme.of(context).textTheme.titleMedium),
            WrapText(text: '#flutter', onTap: () {}),
            const VerticalSpace(2),
            if (postModel.postImage != '')
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CacheImage(
                  image: postModel.postImage.toString(),
                  height: context.heightInPercent(35),
                  width: double.infinity,
                  boxFit: BoxFit.cover,
                ),
              ),
            const VerticalSpace(1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(IconBroken.heart, color: Colors.red),
                    const HorizontalSpace(1),
                    Text("${postModel.likes!.length}")
                  ],
                ),
                Row(
                  children: const [
                    Icon(IconBroken.chat, color: Colors.amber),
                    HorizontalSpace(1),
                    Text('120 comment')
                  ],
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                CircleImage(text: postModel.image, radius: 5),
                const HorizontalSpace(3),
                const Text('write a comment ...'),
                const Spacer(),
                BlocBuilder<PostCubit, PostState>(
                  builder: (context, state) {
                    return IconTextButton(
                      color: Colors.red,
                      text: 'Like',
                      icon: postModel.likes!.contains(userCubit.userModel?.uId)
                          ? Icons.favorite
                          : IconBroken.heart,
                      onTap: () {
                        postCubit.like(likes: postModel.likes,postId: postModel.postId);
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
