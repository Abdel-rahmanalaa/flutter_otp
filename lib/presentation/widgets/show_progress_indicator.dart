import 'package:flutter/material.dart';
import 'package:flutter_otp/resources/app_colors.dart';

void showProgressIndicator(BuildContext context) {
  AlertDialog alertDialog = const AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.black),
      ),
    ),
  );
  showDialog(
    barrierColor: AppColorsWithOpacity.whiteOfZero,
    barrierDismissible: false,
    context: context,
    builder: (context) => alertDialog,
  );
}
