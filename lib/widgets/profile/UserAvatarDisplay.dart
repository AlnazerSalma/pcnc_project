import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserAvatarDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocale = AppLocalizations.of(context)!;

    ScreenUtil.init(context, designSize: Size(375, 790));
    return Center(
      child: CircleAvatar(
        radius: 30.r,
        backgroundImage: AssetImage('assets/images/avatar-account.jpg'),
      ),
    );
  }
}
