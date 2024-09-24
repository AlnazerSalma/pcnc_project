part of '../views/auth_screen.dart';

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
        if (isLogin)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed:onForgotPassword,
                child: CustomText(
                  text: appLocale.forgotPasswordQ,
                  color: kRed,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
    );
  }
}

