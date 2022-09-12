import 'package:social_app_firebase/features/features_exports.dart';

class CustomSettingsText extends StatelessWidget {
  const CustomSettingsText({super.key, required this.num, required this.text});

  final String num, text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(num, style: Theme.of(context).textTheme.titleLarge),
        const VerticalSpace(1),
        Text(text,
            style: const TextStyle(
                color: AppColors.grey,
                fontSize: 15,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
