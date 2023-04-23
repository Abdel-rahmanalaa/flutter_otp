// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp/app/shared_components.dart';
import 'package:flutter_otp/controller/cubit/phone_Auth/cubit/phone_auth_cubit.dart';
import 'package:flutter_otp/presentation/screens/verification_screen.dart';
import 'package:flutter_otp/presentation/widgets/custom_elevated_button.dart';
import 'package:flutter_otp/presentation/widgets/custom_text.dart';
import 'package:flutter_otp/presentation/widgets/show_progress_indicator.dart';
import 'package:flutter_otp/resources/app_colors.dart';
import 'package:flutter_otp/resources/app_fonts.dart';
import 'package:flutter_otp/resources/app_strings.dart';
import 'package:flutter_otp/resources/app_values.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class OtpScreen extends StatelessWidget {
  OtpScreen({super.key, required this.phoneNumber});

  final phoneNumber;
  late String otpCode;

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
              _buildVerifyButton(context),
              _buildPhoneNumberVerificationBloc(),
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
        length: AppSize.s6.toInt(),
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
          otpCode = code;
          print("Completed");
        },
        onChanged: (value) {
          print(value);
        },
      ),
    );
  }

  Widget _buildVerifyButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: AppPadding.p3),
        child: CustomElevatedButton(
          onPressed: () {
            showProgressIndicator(context);
            _login(context);
          },
          buttonChild: CustomText(
            text: AppStrings.verify,
            textColor: AppColors.white,
            textSize: AppFontSize.s16,
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumberVerificationBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
        }
        if (state is PhoneOTPVerified) {
          navigatePop(context);
          navigateAndFinish(context, VerifyScreen());
        }

        if (state is ErrorOccurred) {
          //navigatePop(context);
          String errorMsg = (state).error;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: AppColors.black,
              duration: const Duration(seconds: 5),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  void _login(BuildContext context) {
    BlocProvider.of<PhoneAuthCubit>(context).submitOTP(otpCode);
  }
}
