import 'package:social_app_firebase/features/features_exports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return WillPopScope(
        onWillPop: () => AppConstants().showExitPopup(context),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: authCubit.loginForm,
              child: SingleChildScrollView(
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is LoginError) {
                      return AppConstants().showToast(
                          msg: state.error, color: Colors.red);
                    }
                    // else if (state is LoginLoaded) {
                    //   RestartWidget.restartApp(context);
                    //    }
                  },
                  builder: (context, state) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const VerticalSpace(20),
                      Text(
                        '${context.tr?.login}',
                        style: const TextStyle(fontSize: 40),
                      ),
                      const VerticalSpace(7),
                      CustomTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email,
                        controller: authCubit.loginEmailController,
                        validator: (String? value) =>
                            validInput(context, value!, 10, 30, 'email'),
                        labelText: '${context.tr?.email}',
                        hintText: '${context.tr?.emailHint}',
                      ),
                      const VerticalSpace(4),
                      CustomTextFormField(
                        controller: authCubit.loginPasswordController,
                        prefixIcon: Icons.lock,
                        suffixIcon: authCubit.changeIcon,
                        onPressedSuffixIcon: authCubit.changeVisibility,
                        obscureText: authCubit.changeObscure,
                        validator: (String? value) =>
                            validInput(context, value!, 6, 30, 'password'),
                        labelText: '${context.tr?.password}',
                        hintText: '${context.tr?.passwordHint}',
                      ),
                      const VerticalSpace(7),
                      state is LoginLoading
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                              title: '${context.tr?.login}',
                              onTap: () => authCubit.login(context),

                            ),
                      const VerticalSpace(2),
                      CustomTextBottom(
                          text: '${context.tr?.doNotHaveAnAccount}  ',
                          textBottom: '${context.tr?.register}',
                          routeName: Routes.registerScreen),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
  }
}
