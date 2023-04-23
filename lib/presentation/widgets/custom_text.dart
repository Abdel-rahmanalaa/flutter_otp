import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  String text;
  Color? textColor;
  double? textSize;
  FontWeight? textWieght;
  double? latterSpace;
  TextAlign? textAlign;

  CustomText({
    super.key,
    required this.text,
    this.textColor,
    this.textSize,
    this.textWieght,
    this.latterSpace,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: textColor,
        fontSize: textSize,
        fontWeight: textWieght,
        letterSpacing: latterSpace,
      ),
    );
  }
}
