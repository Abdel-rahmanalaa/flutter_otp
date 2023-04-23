import 'package:flutter/material.dart';
import 'package:flutter_otp/resources/app_colors.dart';
import 'package:flutter_otp/resources/app_values.dart';

// ignore: must_be_immutable
class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonChild,
    this.buttonHeight,
    this.buttonWidth,
  });

  void Function()? onPressed;
  Widget buttonChild;
  double? buttonWidth;
  double? buttonHeight;
  //Color? buttonBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize:
            Size(buttonWidth ?? AppSize.s110, buttonHeight ?? AppSize.s50),
        backgroundColor: AppColors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s6),
        ),
      ),
      child: buttonChild,
    );
  }
}
