import 'package:aitek_task/core/theme/style.dart';
import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  String? title;
  VoidCallback? onPress;
  Color? bgColor;
  Color? borderColor;
  Color? splashColor;
  Color? textColor;
  double? height;
  double? borderRadius;
  Widget? child;

  CustomButton(
      {super.key, this.title, this.onPress, this.textColor, this.bgColor, this.borderColor, this.child, this.borderRadius, this.splashColor, this.height});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height ?? 50,
      minWidth: double.infinity,
      elevation: 0.0,
      splashColor: splashColor ?? Colors.transparent,
      color: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.0), side: BorderSide(color: borderColor ?? Colors.transparent)),
      onPressed: onPress,
      child: child ??
          Text(
            "$title",
            textAlign: TextAlign.center,
            style: kRegularTextStyle.copyWith(fontWeight: FontWeight.w400, color: textColor, height: 1.0),
          ),
    );
  }
}
