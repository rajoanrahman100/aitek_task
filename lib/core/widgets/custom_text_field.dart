import 'package:aitek_task/core/theme/style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? textStyle;
  final Color cursorColor;
  final BorderRadius borderRadius;
  final bool isError;
  final bool enabled;
  final Color fillColor;
  final int? maxLength;
  final int? maxLine;
  final bool showCounter;
  final TextStyle? counterStyle;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.validator,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.textStyle,
    this.cursorColor = Colors.black,
    this.isError = false,
    this.enabled = true,
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    this.fillColor = Colors.transparent,
    this.maxLength,
    this.maxLine,
    this.showCounter = false,
    this.counterStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: ((maxLength != null || maxLine != null) && showCounter)
            ? 72
            : 52,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        onChanged: onChanged,
        style: textStyle ?? kRegularTextStyle,
        cursorColor: cursorColor,
        enabled: enabled,
        maxLength: maxLength,
        maxLines: obscureText ? 1 : maxLine,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 16.0,
          ),
          hintText: hintText,
          filled: true,
          fillColor: fillColor,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          errorStyle: const TextStyle(color: Colors.redAccent),
          suffixIconConstraints: const BoxConstraints(
            minHeight: 18,
            minWidth: 18,
          ),
          prefixIconConstraints: const BoxConstraints(
            minHeight: 18,
            minWidth: 18,
          ),
          counterText: maxLength != null && !showCounter ? '' : null,
          counterStyle: counterStyle,
          border: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              color: isError ? Colors.redAccent : Colors.black12,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              color: isError ? Colors.redAccent : Colors.black12,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              color: enabled ? Colors.redAccent : Colors.black12,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              color: isError ? Colors.redAccent : Colors.black12,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(color: Colors.redAccent, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(color: Colors.redAccent, width: 1),
          ),
        ),
      ),
    );
  }
}
