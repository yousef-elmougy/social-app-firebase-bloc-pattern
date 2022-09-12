import 'package:social_app_firebase/core/widgets/empty_widget.dart';
import 'package:social_app_firebase/core/widgets/error_screen.dart';
import 'package:social_app_firebase/features/features_exports.dart';

import '../widgets/home/post_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postCubit = BlocProvider.of<PostCubit>(context);
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async => postCubit.getNewPost(),
          child: postCubit.postList.isEmpty
              ? const EmptyWidget(icon: IconBroken.home, text: 'Add Post')
              : state is GetPostLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state is GetPostError
                      ? Center(child: ErrorScreen(onTap: postCubit.getNewPost))
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: postCubit.postList.length,
                          itemBuilder: (context, index) =>
                              PostItem(postModel: postCubit.postList[index]),
                        ),
        );
      },
    );
  }
}
