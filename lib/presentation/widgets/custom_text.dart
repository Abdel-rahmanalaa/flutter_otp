import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  String text;
  Color? textColor;
  double? textSize;
  FontWeight? textWieght;
  double? latterSpace;

  CustomText({
    super.key,
    required this.text,
    this.textColor,
    this.textSize,
    this.textWieght,
    this.latterSpace,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: textSize,
        fontWeight: textWieght,
        letterSpacing: latterSpace,
      ),
    );
  }
}
