import 'package:social_app_firebase/features/features_exports.dart';
import 'package:uuid/uuid.dart';

part 'posts_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit({required this.newPostRepository}) : super(PostsInitial());
  final PostRepository newPostRepository;

  /// CREATE NEW POST
  final TextEditingController newPostController = TextEditingController();

  Future<void> createNewPost(context) async {
    emit(CreatePostLoading());
    final userModel = BlocProvider.of<UserCubit>(context).userModel;

    await newPostRepository
        .createPost(
            userModel: userModel,
            dateTime: DateTime.now(),
            text: newPostController.text,
            postImage: postImage,
            postId: const Uuid().v1())
        .then((value) => value.fold(
                (failure) => emit(
                    CreatePostError(Methods().mapFailureToMsg(failure))),
                (value) {
              emit(CreatePostLoaded());
              Navigator.pop(context);
              newPostController.clear();
              clearImage();
            }));
  }

  /// Get NEW POST
  List<PostModel> postList = [];

void  getNewPost()  {
    emit(GetPostLoading());
    newPostRepository.getPost().listen((event) {
      postList =
        event.docs.map((e) => PostModel.fromJson(e.data())).toList();
      emit(GetPostLoaded());
    });
  }

  /// LIKE
  Future<void> like({List? likes, String? postId}) async {
    if (likes!.contains(AppStrings.uId)) {
      await FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayRemove([AppStrings.uId])
      });
      emit(PostsUnLike());
    } else {
      await FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayUnion([AppStrings.uId])
      });
      emit(PostsLike());
    }
  }

  /// PICK POST IMAGE
  // File? postImageFile;
  Uint8List? postImageFile;

  Future<void> pickPostImage() async {
    postImageFile = await Methods().pickImage();
    emit(PickPostImage());
    if (postImageFile != null) {
      uploadPostImage();
    }
  }

  String? postImage;

  Future<void> uploadPostImage() async {
    emit(UploadPostImageLoading());
    postImage = await Methods().uploadImageToStorage(
        childName: 'posts', file: postImageFile, isPost: true);
    emit(UploadPostImageLoaded());
  }

  void clearImage() {
    postImageFile = null;
    postImage = '';
    emit(ClearImage());
  }
}
