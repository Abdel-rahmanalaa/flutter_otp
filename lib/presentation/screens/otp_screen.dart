import 'package:flutter/material.dart';
import 'package:flutter_otp/presentation/widgets/custom_text.dart';
import 'package:flutter_otp/resources/app_colors.dart';
import 'package:flutter_otp/resources/app_fonts.dart';
import 'package:flutter_otp/resources/app_strings.dart';
import 'package:flutter_otp/resources/app_values.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  late final phoneNumber;
  //late String otpCode;

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
              _buildPinCodeFields(context),
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
          text: AppStrings.verifyNumber,
          textColor: AppColors.black,
          textSize: AppFontSize.s24,
          textWieght: AppFontWight.bold,
        ),
        const SizedBox(
          height: AppSize.s30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m2),
          child: RichText(
            text: TextSpan(
              text: AppStrings.enterCode,
              style: const TextStyle(
                  color: AppColors.black,
                  fontSize: AppFontSize.s18,
                  height: AppSize.s1_5),
              children: <TextSpan>[
                TextSpan(
                    text: '$phoneNumber',
                    style: const TextStyle(
                      color: AppColors.blue,
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPinCodeFields(BuildContext context) {
    return Container(
      child: PinCodeTextField(
        appContext: context,
        cursorColor: AppColors.black,
        keyboardType: TextInputType.number,
        autoFocus: true,
        length: AppSize.s10.toInt(),
        obscureText: false,
        animationType: AnimationType.scale,
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(AppSize.s6),
            fieldHeight: AppSize.s50,
            fieldWidth: AppSize.s40,
            borderWidth: AppSize.s1,
            activeColor: AppColors.blue,
            inactiveColor: AppColors.blue,
            activeFillColor: AppColors.lightBlue,
            inactiveFillColor: AppColors.white,
            selectedColor: AppColors.blue,
            selectedFillColor: AppColors.white),
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: AppColors.white,
        enableActiveFill: true,
        onCompleted: (code) {
          //otpCode = code;
          print("Completed");
        },
        onChanged: (value) {
          print(value);
        },
      ),
    );
  }

  Widget _buildVerifyButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: AppPadding.p3),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(AppSize.s110, AppSize.s50),
              backgroundColor: AppColors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s6))),
          child: CustomText(
            text: AppStrings.verify,
            textColor: AppColors.white,
            textSize: AppFontSize.s16,
          ),
        ),
      ),
    );
  }
}
