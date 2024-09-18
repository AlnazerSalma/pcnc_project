import 'package:flutter/material.dart';
import 'package:pcnc/core/extension/sized_box_ext.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
