import 'package:social_app_firebase/features/features_exports.dart';

class SettingsEditScreen extends StatelessWidget {
  const SettingsEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<UserCubit>(context);
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UpdateUserLoaded) {
          return AppConstants().showToast(
              msg: 'Update Successfully', color: Colors.green);
        }
      },
      builder: (context, state) {
        userCubit.nameController.text =
            '${userCubit.userModel?.name.toString().trim()}';
        userCubit.bioController.text =
            '${userCubit.userModel?.bio.toString().trim()}';
        userCubit.phoneController.text =
            '${userCubit.userModel?.phone.toString().trim()}';

        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: TextButton(
                  onPressed:  state is UploadImageLoading
                      ? null
                      : () {
                    if (userCubit.formSittings.currentState!.validate()) {
                     userCubit.updateUser(context);
                    }
                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Form(
                key: userCubit.formSittings,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    const SettingsEditImages(),
                    const VerticalSpace(3),
                    CustomTextFormField(
                      labelText: 'name',
                      hintText: 'name',
                      prefixIcon: IconBroken.profile,
                      validator: (String? value) =>
                          validInput(context, value!, 3, 20, 'username'),
                      controller: userCubit.nameController,
                    ),
                    const VerticalSpace(3),
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.phone,
                      controller: userCubit.phoneController,
                      validator: (String? value) =>
                          validInput(context, value!, 7, 11, 'phone'),
                      labelText: 'phone',
                      hintText: 'phone',
                    ),
                    const VerticalSpace(3),
                    CustomTextFormField(
                      labelText: 'bio',
                      hintText: 'bio',
                      maxLines: 4,
                      controller: userCubit.bioController,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
