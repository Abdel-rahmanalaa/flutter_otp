import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp/config/locale/app_localizations.dart';
import 'package:flutter_otp/core/components/shared_components.dart';
import 'package:flutter_otp/presentation/controller/phone_Auth/cubit/phone_auth_cubit.dart';
import 'package:flutter_otp/presentation/widgets/custom_elevated_button.dart';
import 'package:flutter_otp/presentation/widgets/custom_text.dart';
import 'package:flutter_otp/core/utils/resources/app_colors.dart';
import 'package:flutter_otp/core/utils/resources/app_fonts.dart';
import 'package:flutter_otp/config/routes/app_routes.dart';
import 'package:flutter_otp/core/utils/resources/app_values.dart';

// ignore: must_be_immutable
class VerifyScreen extends StatelessWidget {
  VerifyScreen({super.key});

  PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(
              vertical: AppMargin.m88, horizontal: AppMargin.m20),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: AppSize.s100,
              ),
              _buildVerifiedIcon(),
              const SizedBox(
                height: AppSize.s20,
              ),
              _buildVerificationText(context),
              const SizedBox(
                height: AppSize.s250,
              ),
              _buildSignOutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerifiedIcon() {
    return const Icon(
      Icons.verified,
      color: AppColors.blue,
      size: AppSize.s140,
    );
  }

  Widget _buildVerificationText(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return CustomText(
      text: appLocalization.translate('verification_text')!,
      textColor: AppColors.black,
      textSize: AppFontSize.s28,
      textWieght: AppFontWight.bold,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSignOutButton(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return BlocProvider<PhoneAuthCubit>(
      create: (context) => phoneAuthCubit,
      child: CustomElevatedButton(
        onPressed: () async {
          await phoneAuthCubit.logOut();
          if (context.mounted) {
            navigatePushReplacment(context, RoutesName.loginRoute);
          }
        },
        buttonWidth: double.infinity,
        buttonChild: CustomText(
          text: appLocalization.translate('log_out')!,
          textColor: AppColors.white,
          textSize: AppFontSize.s16,
        ),
      ),
    );
  }
}
