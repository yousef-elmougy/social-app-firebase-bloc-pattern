import 'package:social_app_firebase/features/features_exports.dart';

class WrapText extends StatelessWidget {
  const WrapText({Key? key, this.onTap, required this.text}) : super(key: key);

  final GestureTapCallback? onTap;
  final String text;

  @override
  Widget build(BuildContext context) => Wrap(
        direction: Axis.horizontal,
        spacing: 10,
        children: [
          InkWell(
            onTap: onTap,
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
}
