import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pcnc/core/extension/sized_box_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/features/user/presentation/widget/signin_signup_widget.dart';
import 'package:pcnc/presentation/style/color_palette.dart';
import 'package:pcnc/presentation/style/font_sizes.dart';
import 'package:pcnc/presentation/widget/text_widget/rich_text_widget.dart';

class AuthFooter extends StatelessWidget {
  final bool isLogin;
  final VoidCallback onSubmit;
  final VoidCallback onToggle;

  const AuthFooter({
    required this.isLogin,
    required this.onSubmit,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    ScreenUtil.init(context, designSize: const Size(375, 790));

    return Column(
      children: [
        if (!isLogin) ...[
          RichTextWidget(
            firstPart: appLocale.byClickingThe,
            interactiveText: appLocale.register,
            secondPart: appLocale.agreeToPublicOffer,
            onInteractiveTextTap: () {
              // Define the action for interactive text tap if needed
            },
          ),
        ],
        20.height,
        SignInSignUpButton(
          onTap: onSubmit,
          text: isLogin ? appLocale.login : appLocale.createAccount,
          width: MediaQuery.of(context).size.width,
          height: 50.0,
          color: kbuttoncolorColor,
          textColor: kWhiteColor,
          fontSize: textExtraLarge.sp,
        ),
        15.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichTextWidget(
              firstPart: isLogin
                  ? appLocale.dontHaveAnAccountQSignup + " "
                  : appLocale.iAlreadyHaveAnAccount + " ",
              interactiveText: isLogin ? appLocale.signUp : appLocale.login,
              secondPart: "",
              onInteractiveTextTap: onToggle,
            ),
          ],
        ),
      ],
    );
  }
}
