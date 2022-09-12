
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.labelText,
    this.keyboardType,
    this.validator,
    this.onPressedSuffixIcon,
    this.obscureText,
    this.autofocus,
    this.border,
    this.maxLines,
  }) : super(key: key);

  final TextEditingController? controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final void Function()? onPressedSuffixIcon;
  final bool? autofocus;
  final int? maxLines;
  final InputBorder? border;

  @override
  Widget build(BuildContext context) => TextFormField(
        maxLines: maxLines ?? 1,
        autofocus: autofocus ?? false,
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        obscureText: obscureText ?? false,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: onPressedSuffixIcon,
                  icon: Icon(suffixIcon),
                )
              : null,
          border: border ?? const OutlineInputBorder(),
        ),
      );
}
