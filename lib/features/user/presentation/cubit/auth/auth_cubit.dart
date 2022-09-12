import 'package:social_app_firebase/features/features_exports.dart';
import 'package:social_app_firebase/injection_exports.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepository}) : super(AuthInitial());
  final AuthRepository authRepository;

  /// REGISTER

  final registerForm = GlobalKey<FormState>();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerNameController = TextEditingController();
  final TextEditingController registerPhoneController = TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();

  Future<void> register(context) async {
    if (registerForm.currentState!.validate()) {
      emit(RegisterLoading());
      await authRepository
          .register(
              email: registerEmailController.text.trim(),
              password: registerPasswordController.text.trim())
          .then((value) => value.fold(
                  (failure) => emit(
                      RegisterError(Methods().mapFailureToMsg(failure))),
                  (value) {
                BlocProvider.of<UserCubit>(context).createUser(
                    name: registerNameController.text.trim(),
                    email: value.user?.email,
                    phone: registerPhoneController.text.trim(),
                    uId: value.user?.uid);
                emit(RegisterLoaded());
                // RestartWidget.restartApp(context);
                  }));
    }
  }

  /// LOGIN

  final loginForm = GlobalKey<FormState>();
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  Future<void> login(context) async {
    if (loginForm.currentState!.validate()) {
      emit(LoginLoading());
      await authRepository
          .login(
              email: loginEmailController.text.trim(),
              password: loginPasswordController.text.trim())
          .then((value) => value.fold(
                  (failure) =>
                      emit(LoginError(Methods().mapFailureToMsg(failure))),
                  (value) {
                emit(LoginLoaded());
                  }));
    }
  }



  /// PASSWORD VISIBILITY
  bool isVisible = false;

  void changeVisibility() => emit(ChangeVisibility(isVisible = !isVisible));

  IconData get changeIcon =>
      isVisible ? Icons.visibility : Icons.visibility_off;

  bool get changeObscure => isVisible ? false : true;
}
