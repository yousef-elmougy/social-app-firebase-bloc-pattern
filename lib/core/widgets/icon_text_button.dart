
import 'package:flutter/material.dart';

import '../utiles/app_colors.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton(
      {Key? key, this.onTap, this.icon, this.color, this.text, this.size})
      : super(key: key);

  final GestureTapCallback? onTap;
  final IconData? icon;
  final Color? color;
  final double? size;
  final String? text;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: color, size: size),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('$text',
                  style: TextStyle(color: AppColors.black, fontSize: size)),
            ),
          ],
        ),
      );
}
