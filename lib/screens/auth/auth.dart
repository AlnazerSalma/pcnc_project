import 'package:pcnc/cache/cache_controller.dart';
import 'package:pcnc/enums.dart';
import 'package:pcnc/util/color_palette.dart';
import 'package:pcnc/extensions/sized_box_extension.dart';
import 'package:pcnc/helpers/navigator_helper.dart';
import 'package:pcnc/widgets/Buttons/signin_signup.dart';
import 'package:pcnc/screens/auth/Forgot_Password_Screen.dart';
import 'package:pcnc/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthScreen();
  }
}

class _AuthScreen extends State<AuthScreen> with NavigatorHelper {
  AppLocalizations get appLocale => AppLocalizations.of(context)!;

  final _form = GlobalKey<FormState>();
  var _isLogin = true;
  var _enteredUsernameOrEmail = '';
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredRePassword = '';
  bool hidden = true;
  bool hiddenRePassword = true;

  Future<void> _submit() async {
    // Your submit logic
  }

  Future<void> get _navigateToHome async{}
      

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 790));
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(color: Theme.of(context).colorScheme.background),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(20.dg),
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16.dg),
                      child: Form(
                        key: _form,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            50.height,
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                _isLogin
                                    ? appLocale.welcomeBack
                                    : appLocale.createAnAccount,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      fontSize: 40.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            20.height,
                            if (!_isLogin) ...[
                              CustomTextFormField(
                                onSaved: (value) =>
                                    _enteredUsernameOrEmail = value!,
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
                              CustomTextFormField(
                                onSaved: (value) => _enteredEmail = value!,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty ||
                                      !value.contains('@')) {
                                    return appLocale
                                        .pleaseEnterValidEmailAddress;
                                  }
                                  return null;
                                },
                                labelText: appLocale.emailAddress,
                                icon: Icons.email,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              20.height,
                            ],
                            if (_isLogin) ...[
                              CustomTextFormField(
                                onSaved: (value) =>
                                    _enteredUsernameOrEmail = value!,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return appLocale.pleaseEnterUsernameOrEmail;
                                  }
                                  return null;
                                },
                                labelText: appLocale.usernameOrEmail,
                                icon: Icons.person,
                                keyboardType: TextInputType.text,
                              ),
                              20.height,
                            ],
                            CustomTextFormField(
                              onSaved: (value) => _enteredPassword = value!,
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return appLocale
                                      .passwordMustBeAtLeast6CharactersLong;
                                }
                                return null;
                              },
                              labelText: appLocale.password,
                              icon: Icons.lock,
                              isPasswordField: true,
                            ),
                            if (!_isLogin) ...[
                              20.height,
                              CustomTextFormField(
                                onSaved: (value) => _enteredRePassword = value!,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty ||
                                      value != _enteredPassword) {
                                    return appLocale.passwordsDoNotMatch;
                                  }
                                  return null;
                                },
                                labelText: appLocale.renterPassword,
                                icon: Icons.lock,
                                isPasswordField: true,
                              ),
                              20.height,
                            ],
                            if (_isLogin) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () => jumpTo(
                                      context,
                                      to: ForgotPasswordScreen(),
                                    ),
                                    child: Text(
                                      appLocale.forgotPasswordQ,
                                      style: TextStyle(
                                        color: kRed,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            if (!_isLogin) ...[
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.dg),
                                child: RichText(
                                  text: TextSpan(
                                    text: appLocale.byClickingThe,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          fontSize: 13.sp,
                                        ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: appLocale.register,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: kRed,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      TextSpan(
                                          text: appLocale.agreeToPublicOffer),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            12.height,
                            CustomButton(
                              onTap: () async {
                                // Your button logic
                              },
                              text:
                                  _isLogin ? appLocale.login : appLocale.signUp,
                              width: MediaQuery.of(context).size.width,
                              height: 50.0,
                              color: kbuttoncolorColor,
                              textColor: kWhiteColor,
                              fontSize: 18.0,
                            ),
                            10.height,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isLogin = !_isLogin;
                                    });
                                  },
                                  child: Center(
                                    child: Text.rich(
                                      TextSpan(
                                        text: _isLogin
                                            ? appLocale
                                                    .dontHaveAnAccountQSignup +
                                                " "
                                            : appLocale.iAlreadyHaveAnAccount +
                                                " ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                              fontSize: 12.sp,
                                            ),
                                        children: [
                                          TextSpan(
                                            text: _isLogin
                                                ? appLocale.signUp
                                                : appLocale.login,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  color:
                                                      kRed,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
