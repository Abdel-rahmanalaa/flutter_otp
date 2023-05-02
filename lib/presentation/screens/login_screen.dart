import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp/config/locale/app_localizations.dart';
import 'package:flutter_otp/core/components/shared_components.dart';
import 'package:flutter_otp/core/functions/functions.dart';
import 'package:flutter_otp/presentation/controller/locale/cubit/locale_cubit.dart';
import 'package:flutter_otp/presentation/controller/phone_Auth/cubit/phone_auth_cubit.dart';
import 'package:flutter_otp/presentation/widgets/custom_container.dart';
import 'package:flutter_otp/presentation/widgets/custom_elevated_button.dart';
import 'package:flutter_otp/presentation/widgets/custom_expanded.dart';
import 'package:flutter_otp/presentation/widgets/custom_text.dart';
import 'package:flutter_otp/presentation/widgets/show_progress_indicator.dart';
import 'package:flutter_otp/core/utils/resources/app_colors.dart';
import 'package:flutter_otp/core/utils/resources/app_fonts.dart';
import 'package:flutter_otp/config/routes/app_routes.dart';
import 'package:flutter_otp/core/utils/resources/app_strings.dart';
import 'package:flutter_otp/core/utils/resources/app_values.dart';

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
        appBar: AppBar(
          backgroundColor: AppColors.black,
          leading: IconButton(
            icon: const Icon(
              Icons.translate_outlined,
              color: AppColors.white,
            ),
            onPressed: () {
              if (AppLocalizations.of(context)!.isEnLocale) {
                BlocProvider.of<LocaleCubit>(context).toArabic();
              } else {
                BlocProvider.of<LocaleCubit>(context).toEnglish();
              }
            },
          ),
        ),
        backgroundColor: AppColors.white,
        body: Form(
          key: _phoneFormKey,
          child: Container(
            margin: const EdgeInsets.symmetric(
                vertical: AppMargin.m88, horizontal: AppMargin.m32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIntroText(context),
                const SizedBox(
                  height: AppSize.s120,
                ),
                _buildFormField(),
                const SizedBox(
                  height: AppSize.s60,
                ),
                _bulidNextButton(context),
                _buildPhoneNumberSubmitedBloc(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIntroText(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: appLocalization.translate('ask_about_number')!,
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
            text: appLocalization.translate('plz_enter_phone_to_verify')!,
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
    final appLocalization = AppLocalizations.of(context)!;
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: AppPadding.p3),
        child: CustomElevatedButton(
          onPressed: () {
            showProgressIndicator(context);
            _register(context);
          },
          buttonChild: CustomText(
            text: appLocalization.translate('next')!,
            textColor: AppColors.white,
            textSize: AppFontSize.s16,
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumberSubmitedBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
        }
        if (state is PhoneNumberSubmited) {
          navigatePop(context);
          navigatePushNamed(context, RoutesName.otpRoute, phoneNumber);
        }

        if (state is ErrorOccurred) {
          navigatePop(context);
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

  Future<void> _register(BuildContext context) async {
    if (!_phoneFormKey.currentState!.validate()) {
      navigatePop(context);
      return;
    } else {
      _phoneNumberValidated(context);
    }
  }

  Future<void> _phoneNumberValidated(BuildContext context) async {
    navigatePop(context);
    _phoneFormKey.currentState!.save();
    BlocProvider.of<PhoneAuthCubit>(context).submitPhoneNumber(phoneNumber);
  }
}
