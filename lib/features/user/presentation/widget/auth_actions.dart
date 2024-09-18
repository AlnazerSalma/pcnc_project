import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/core/application_manager/navigation_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/features/user/presentation/views/forgot_pass_screen.dart';
import 'package:pcnc/presentation/style/color_palette.dart';
import 'package:pcnc/presentation/widget/text_widget/custom_text.dart';

class AuthActions extends StatelessWidget {
  final bool isLogin;
  final VoidCallback onForgotPassword;

  const AuthActions({
    required this.isLogin,
    required this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 790));
    final appLocale = AppLocalizations.of(context)!;
    return Column(
      children: [
        if (isLogin) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  final navigationManager = NavigationManager(context);
                  navigationManager.navigateTo(ForgotPasswordScreen());
                },
                child: CustomText(
                  text: appLocale.forgotPasswordQ,
                  color: kRed,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

