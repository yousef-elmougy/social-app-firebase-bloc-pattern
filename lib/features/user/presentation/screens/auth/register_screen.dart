import 'package:social_app_firebase/features/features_exports.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
              key: authCubit.registerForm,
              child: SingleChildScrollView(
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is RegisterError) {
                      return AppConstants().showToast(
                          msg: state.error, color: Colors.red);
                    }
                    // else if (state is RegisterLoaded) {
                    //   RestartWidget.restartApp(context);
                    // }
                  },
                  builder: (context, state) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const VerticalSpace(10),
                      Text('${context.tr?.register}',
                          style: const TextStyle(fontSize: 40)),
                      const VerticalSpace(5),
                      CustomTextFormField(
                        prefixIcon: Icons.person,
                        controller: authCubit.registerNameController,
                        validator: (String? value) =>
                            validInput(context, value!, 3, 20, 'username'),
                        labelText: '${context.tr?.name}',
                        hintText: '${context.tr?.nameHint}',
                      ),
                      const VerticalSpace(3),
                      CustomTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email,
                        controller: authCubit.registerEmailController,
                        validator: (String? value) =>
                            validInput(context, value!, 10, 30, 'email'),
                        labelText: '${context.tr?.email}',
                        hintText: '${context.tr?.emailHint}',
                      ),
                      const VerticalSpace(3),
                      CustomTextFormField(
                        keyboardType: TextInputType.number,
                        prefixIcon: Icons.phone,
                        controller: authCubit.registerPhoneController,
                        validator: (String? value) =>
                            validInput(context, value!, 7, 11, 'phone'),
                        labelText: '${context.tr?.phone}',
                        hintText: '${context.tr?.phoneHint}',
                      ),
                      const VerticalSpace(3),
                      CustomTextFormField(
                        controller:
                            authCubit.registerPasswordController,
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
                      state is RegisterLoading
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                              title: '${context.tr?.register}',
                              onTap: ()  {
                                authCubit.register(context);
                              },
                            ),
                      const VerticalSpace(1),
                      CustomTextBottom(
                          text: '${context.tr?.haveAnAccount}  ',
                          textBottom: '${context.tr?.login}',
                          routeName: Routes.loginScreen),
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
