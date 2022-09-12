import 'package:social_app_firebase/features/features_exports.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required this.chatRepository}) : super(ChatInitial());

  final ChatRepository chatRepository;

  final TextEditingController messageController = TextEditingController();

  Future<void> sendMessage({String? receiverId}) async {
    emit(SendMessageLoading());
    await chatRepository
        .sendMessage(
            senderId: AppStrings.uId,
            receiverId: receiverId,
            chatImage: chatImage,
            dateTime: DateTime.now(),
            text: messageController.text)
        .then((value) => value.fold(
            (failure) =>
                emit(SendMessageError(Methods().mapFailureToMsg(failure))),
            (value) {
              messageController.clear();
              emit(SendMessageLoaded());
            }));
  }

  /// GET MESSAGE
  List<ChatModel> messages = [];

  void getMessage({String? receiverId}) {
    emit(GetMessageLoading());
    chatRepository
        .getMessage(senderId: AppStrings.uId, receiverId: receiverId)
        .listen((event) => messages =
            event.docs.map((e) => ChatModel.fromJson(e.data())).toList());
    emit(GetMessageLoaded());
  }

  /// PICK POST IMAGE
  File? chatImageFile;

  Future<void> pickPostImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage == null) return;

      chatImageFile = File(pickedImage.path);
      emit(PickChatImage());
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  String? chatImage;

  Future<void> uploadCircleImage() async {
    emit(UploadChatImageLoading());
    if (chatImageFile == null) return emit(UploadChatImageError());
    await FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(chatImageFile!.path).pathSegments.last}')
        .putFile(chatImageFile!)
        .then((value) => value.ref.getDownloadURL().then((value) {
              chatImage = value;
              emit(UploadChatImageLoaded());
            }));
  }

  void clearImage() {
    chatImageFile = null;
    chatImage = '';
    emit(ClearImage());
  }
}
