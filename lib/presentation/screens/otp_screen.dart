import 'package:flutter/material.dart';
import 'package:flutter_otp/presentation/widgets/custom_text.dart';
import 'package:flutter_otp/resources/app_colors.dart';
import 'package:flutter_otp/resources/app_fonts.dart';
import 'package:flutter_otp/resources/app_strings.dart';
import 'package:flutter_otp/resources/app_values.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Container(
          margin: const EdgeInsets.symmetric(
              vertical: AppMargin.m88, horizontal: AppMargin.m32),
          child: Column(
            children: [
              _buildIntroText(),
              const SizedBox(
                height: AppSize.s88,
              ),
              _buildPinCodeFields(),
              const SizedBox(
                height: AppSize.s60,
              ),
              _buildVerifyButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: AppStrings.askAboutNumber,
          textColor: AppColors.black,
          textSize: AppFontSize.s24,
          textWieght: AppFontWight.bold,
        ),
        const SizedBox(
          height: AppSize.s30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m2),
          child: CustomText(
            text: AppStrings.plzEnterPhoneToverify,
            textColor: AppColors.black,
            textSize: AppFontSize.s18,
          ),
        ),
      ],
    );
  }
}
