import 'package:pcnc/core/extension/sized_box_ext.dart';
import 'package:pcnc/core/constant/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/core/util/Input_decoration_util.dart';
import 'package:pcnc/core/constant/font_sizes.dart';

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
    ScreenUtil.init(context, designSize: Size(375, 790));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          appLocale.forgotPasswordQ,
          style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
              fontSize: textExtraLarge.sp),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 40.h,
              ),
              10.height,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Text(
                  appLocale.enterYourEmailAddress,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: textMedium.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              20.height,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.w),
                child: TextFormField(
                  controller: forgetPasswordController,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.surface),
                  decoration: buildInputDecoration(
                      context, appLocale.email, Icons.email),
                  cursorColor: Theme.of(context).colorScheme.surface,
                ),
              ),
              14.height,
              Text(
                '• ${appLocale.weWillSendYouMessageToSetOrResetYourNewPassword}',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: textTiny.sp),
              ),
              40.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.0.w),
                    child: Text(
                      appLocale.sendCode,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: textMedium.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.0.w),
                    child: Container(
                      width: 50.0.w,
                      height: 50.0.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: kbuttoncolorColor.withOpacity(0.8),
                            spreadRadius: 5.r,
                            blurRadius: 7.r,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () async {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: CircleBorder(),
                          padding: EdgeInsets.zero,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Theme.of(context).colorScheme.surface,
                          size: 20.dm,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
