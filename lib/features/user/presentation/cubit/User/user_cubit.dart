import 'package:social_app_firebase/features/features_exports.dart';
import '../../../data/models/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.userRepository}) : super(UserInitial());
  final UserRepository userRepository;

  /// CREATE USER

  Future<void> createUser({String? name, phone, email, uId}) async {
    emit(CreateUserLoading());
    await userRepository
        .createUser(uId: uId, phone: phone, email: email, name: name)
        .then((value) => value.fold(
            (failure) =>
                emit(CreateUserError(Methods().mapFailureToMsg(failure))),
            (value) => emit(CreateUserLoaded())));
  }

  /// UPDATE USER
  final TextEditingController bioController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final formSittings = GlobalKey<FormState>();
  UserModel? userModel;

  Future<void> updateUser(context) async {
    emit(UpdateUserLoading());
    await userRepository
        .updateUser(
            uId: AppStrings.uId,
            bio: bioController.text.trim(),
            phone: phoneController.text.trim(),
            name: nameController.text.trim(),
            email: userModel?.email,
            cover: cover ?? userModel!.cover,
            image: image ?? userModel!.image)
        .then((value) => value.fold(
                (failure) =>
                    emit(UpdateUserError(Methods().mapFailureToMsg(failure))),
                (value) {
              emit(UpdateUserLoaded());
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            }));
  }

  /// GET USER

  Future<void> getUser() async {
    emit(GetUserLoading());
    userRepository
        .getUser(AppStrings.uId)
        .listen((event) {
          userModel = UserModel.fromJson(event.data());
          emit(GetUserLoaded());
        });
  }

  /// GET ALL USERS

  List<UserModel> users = [];

  void getAllUsers() {
    emit(GetAllUsersLoading());
    userRepository.getAllUsers().listen((event) {
      users = event.docs.map((e) => UserModel.fromJson(e.data())).toList();
      emit(GetAllUsersLoaded());
    });
  }

  /// PICK CIRCLE PROFILE IMAGE

  Uint8List? imageFile;

  Future<void> pickCircleImage() async {
    imageFile = await Methods().pickImage();
    emit(PickedCircle());
    if (imageFile != null) {
      uploadCircleImage();
    }
  }

  /// UPLOAD CIRCLE PROFILE IMAGE

  String? image;

  Future<void> uploadCircleImage() async {
    emit(UploadImageLoading());
    image = await Methods().uploadImageToStorage(
        childName: 'users', file: imageFile, isPost: false);
    emit(UploadCircleImage());
  }

  /// PICK COVER PROFILE IMAGE

  Uint8List? coverFile;

  Future<void> pickCoverImage() async {
    coverFile = await Methods().pickImage();
    emit(PickedCircle());
    if (coverFile != null) {
      uploadCoverImage();
    }
  }

  /// UPLOAD COVER PROFILE IMAGE

  String? cover;

  Future<void> uploadCoverImage() async {
    emit(UploadImageLoading());
    cover = await Methods().uploadImageToStorage(
        childName: 'users', file: coverFile, isPost: false);
    emit(UploadCircleImage());
  }
}
