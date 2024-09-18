import 'package:pcnc/core/extension/sized_box_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/features/user/presentation/widget/form_field_widget.dart';
import 'package:pcnc/presentation/style/color_palette.dart';
import 'package:pcnc/presentation/style/font_sizes.dart';
import 'package:pcnc/presentation/widget/app_bar_widget/custom_app_bar.dart';
import 'package:pcnc/presentation/widget/button/circle_button.dart';
import 'package:pcnc/presentation/widget/text_widget/custom_text.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  AppLocalizations get appLocale => AppLocalizations.of(context)!;
  TextEditingController forgetPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: appLocale.forgotPasswordQ,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: Center(
          child: Column(
            children: [
              40.height,
              CustomText(
                text: appLocale.enterYourEmailAddress,
                fontWeight: FontWeight.bold,
                fontSize: textExtraLarge,
                textAlign: TextAlign.left,
              ),
              20.height,
              CustomFormFieldWidget(
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      !value.contains('@')) {
                    return appLocale.pleaseEnterValidEmailAddress;
                  }
                  return null;
                },
                labelText: appLocale.emailAddress,
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              14.height,
              CustomText(
                text:
                    '• ${appLocale.weWillSendYouMessageToSetOrResetYourNewPassword}',
                fontSize: textmMedium.sp,
                textAlign: TextAlign.start,
              ),
              40.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.0.w),
                    child: CustomText(
                      text: appLocale.sendCode,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CircleButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward,
                      color: kWhiteColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
