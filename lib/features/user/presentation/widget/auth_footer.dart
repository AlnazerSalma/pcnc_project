part of '../views/auth_screen.dart';
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
    return Column(
      children: [
        if (!isLogin) ...[
          RichTextWidget(
            firstPart: appLocale.byClickingThe,
            interactiveText: appLocale.register,
            secondPart: appLocale.agreeToPublicOffer,
            onInteractiveTextTap: () {
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
