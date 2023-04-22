import 'package:flutter/material.dart';
import 'package:flutter_otp/app/functions.dart';
import 'package:flutter_otp/presentation/widgets/custom_container.dart';
import 'package:flutter_otp/presentation/widgets/custom_expanded.dart';
import 'package:flutter_otp/presentation/widgets/custom_text.dart';
import 'package:flutter_otp/resources/app_colors.dart';
import 'package:flutter_otp/resources/app_fonts.dart';
import 'package:flutter_otp/resources/app_routes.dart';
import 'package:flutter_otp/resources/app_strings.dart';
import 'package:flutter_otp/resources/app_values.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController phoneController = TextEditingController();
  late String phoneNumber;
  final GlobalKey<FormState> _phoneFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Form(
          key: _phoneFormKey,
          child: Container(
            margin: const EdgeInsets.symmetric(
                vertical: AppMargin.m88, horizontal: AppMargin.m32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIntroText(),
                const SizedBox(
                  height: AppSize.s120,
                ),
                _buildFormField(),
                const SizedBox(
                  height: AppSize.s60,
                ),
                _bulidNextButton(context),
              ],
            ),
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

  Widget _buildFormField() {
    return Row(
      children: [
        CustomExpanded(
          flex: AppFlexes.f1,
          expandedChild: CustomContainer(
            paddingVertical: AppPadding.p16,
            paddingHorizontal: AppPadding.p12,
            borderColor: AppColors.lightGrey,
            containerChild: _buildCountryField(),
          ),
        ),
        const SizedBox(
          width: AppSize.s16,
        ),
        CustomExpanded(
          flex: AppFlexes.f2,
          expandedChild: CustomContainer(
            widthOfContainer: double.infinity,
            paddingVertical: AppPadding.p2,
            paddingHorizontal: AppPadding.p12,
            borderColor: AppColors.blue,
            containerChild: _buildNmberField(),
          ),
        )
      ],
    );
  }

  Widget _buildCountryField() {
    return CustomText(
      text: generateCountryFlag() + AppStrings.plus20,
      textSize: AppFontSize.s18,
      latterSpace: AppSize.s2,
    );
  }

  Widget _buildNmberField() {
    return TextFormField(
      autofocus: true,
      style: const TextStyle(
        fontSize: AppFontSize.s18,
        letterSpacing: AppSize.s2,
      ),
      decoration: const InputDecoration(border: InputBorder.none),
      cursorColor: AppColors.black,
      keyboardType: TextInputType.phone,
      validator: (value) => validatePhoneNumber(value),
      onSaved: (newValue) => phoneNumber = newValue!,
    );
  }

  Widget _bulidNextButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: AppPadding.p3),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, RoutesName.otpRoute);
          },
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(AppSize.s110, AppSize.s50),
              backgroundColor: AppColors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s6))),
          child: CustomText(
            text: AppStrings.next,
            textColor: AppColors.white,
            textSize: AppFontSize.s16,
          ),
        ),
      ),
    );
  }
}
