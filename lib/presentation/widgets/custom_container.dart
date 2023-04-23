import 'package:flutter/material.dart';
import 'package:flutter_otp/resources/app_values.dart';

// ignore: must_be_immutable
class CustomContainer extends StatelessWidget {
  double paddingVertical;
  double paddingHorizontal;
  late double? widthOfContainer;
  Color borderColor;
  Widget containerChild;

  CustomContainer({
    super.key,
    required this.paddingVertical,
    required this.paddingHorizontal,
    required this.borderColor,
    required this.containerChild,
    this.widthOfContainer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthOfContainer,
      padding: EdgeInsets.symmetric(
          vertical: paddingVertical, horizontal: paddingHorizontal),
      decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s6))),
      child: containerChild,
    );
  }
}
