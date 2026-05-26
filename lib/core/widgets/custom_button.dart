import 'package:aitek_task/core/theme/colors.dart';
import 'package:aitek_task/core/theme/style.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onPress;
  final Color? bgColor;
  final Color? borderColor;
  final Color? splashColor;
  final Color? textColor;
  final double? height;
  final double? borderRadius;
  final Widget? child;

  const CustomButton({
    super.key,
    this.title,
    this.onPress,
    this.textColor,
    this.bgColor,
    this.borderColor,
    this.child,
    this.borderRadius,
    this.splashColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height ?? 50,
      minWidth: double.infinity,
      elevation: 0.0,
      splashColor: splashColor ?? Colors.transparent,
      color: bgColor ?? AppColor.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
        side: BorderSide(color: borderColor ?? Colors.transparent),
      ),
      onPressed: onPress,
      child:
          child ??
          Text(
            "$title",
            textAlign: TextAlign.center,
            style: kRegularTextStyle.copyWith(
              fontWeight: FontWeight.w400,
              color: textColor,
              height: 1.0,
            ),
          ),
    );
  }
}
