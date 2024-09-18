import 'package:flutter/material.dart';
import 'package:pcnc/core/extension/sized_box_ext.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/features/user/presentation/widget/form_field_widget.dart';
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

class AuthFormFields extends StatelessWidget {
  final bool isLogin;
  final GlobalKey<FormState> formKey;
  final Function(String?) onUsernameOrEmailSaved;
  final Function(String?) onEmailSaved;
  final Function(String?) onPasswordSaved;
  final Function(String?) onReenteredPasswordSaved;

  const AuthFormFields({
    required this.isLogin,
    required this.formKey,
    required this.onUsernameOrEmailSaved,
    required this.onEmailSaved,
    required this.onPasswordSaved,
    required this.onReenteredPasswordSaved,
  });

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isLogin) ...[
            CustomFormFieldWidget(
              onSaved: onUsernameOrEmailSaved,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return appLocale.pleaseEnterYourUsername;
                }
                return null;
              },
              labelText: appLocale.username,
              icon: Icons.person,
            ),
           20.height,
            CustomFormFieldWidget(
              onSaved: onEmailSaved,
              validator: (value) {
                if (value == null || value.trim().isEmpty || !value.contains('@')) {
                  return appLocale.pleaseEnterValidEmailAddress;
                }
                return null;
              },
              labelText: appLocale.emailAddress,
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
           20.height,
          ],
          if (isLogin) ...[
            CustomFormFieldWidget(
              onSaved: onUsernameOrEmailSaved,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return appLocale.pleaseEnterUsernameOrEmail;
                }
                return null;
              },
              labelText: appLocale.emailAddress,
              icon: Icons.person,
              keyboardType: TextInputType.text,
            ),
           20.height,
          ],
          CustomFormFieldWidget(
            onSaved: onPasswordSaved,
            validator: (value) {
              if (value == null || value.trim().length < 6) {
                return appLocale.passwordMustBeAtLeast6CharactersLong;
              }
              return null;
            },
            labelText: appLocale.password,
            icon: Icons.lock,
            isPasswordField: true,
          ),
          if (!isLogin) ...[
           20.height,
            CustomFormFieldWidget(
              onSaved: onReenteredPasswordSaved,
              validator: (value) {
                if (value == null || value.trim().length < 6) {
                  return appLocale.passwordMustBeAtLeast6CharactersLong;
                }
                return null;
              },
              labelText: appLocale.renterPassword,
              icon: Icons.lock,
              isPasswordField: true,
            ),
          ],
        ],
      ),
    );
  }
}
