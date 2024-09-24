part of '../views/auth_screen.dart';

class AuthHeader extends StatelessWidget {
  final bool isLogin;

  const AuthHeader({required this.isLogin});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 790));
    final appLocale = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        50.height,
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Text(
            isLogin ? appLocale.welcomeBack : appLocale.createAnAccount,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Theme.of(context).colorScheme.surface,
              fontSize: 46.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
