import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/ApiService/api_service.dart';
import 'package:pcnc/aa/core/cache/cache_controller.dart';
import 'package:pcnc/aa/core/drawer/zoom_drawer.dart';
import 'package:pcnc/aa/core/enums.dart';
import 'package:pcnc/aa/core/extension/sized_box_extension.dart';
import 'package:pcnc/aa/features/user/presentation/views/forgot_pass_screen.dart';
import 'package:pcnc/aa/core/constant/color_palette.dart';
import 'package:pcnc/aa/core/constant/font_sizes.dart';
import 'package:pcnc/aa/features/user/presentation/widget/signin_signup_widget.dart';
import 'package:pcnc/aa/features/user/presentation/widget/form_field_widget.dart';
import 'package:pcnc/aa/core/helper/navigator_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/aa/features/user/presentation/widget/custom_snackbar_widget.dart';

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
  var _reenteredPassword = '';

  bool hidden = true;

  Future<void> _submit() async {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();

      if (!_isLogin && _enteredPassword != _reenteredPassword) {
        CustomSnackBarWidget.show(context, appLocale.passwordsDoNotMatch,
            isError: true);
        return;
      }

      try {
        final apiService = ApiService();
        if (_isLogin) {
          final response = await apiService.loginUser(
            _enteredUsernameOrEmail,
            _enteredPassword,
          );
          await CacheController()
              .setter(key: CacheKeys.token, value: response['access_token']);
          print('Login successful: ${response['access_token']}');
          _navigateToHome();
        } else {
          final response = await apiService.registerUser(
            _enteredUsernameOrEmail,
            _enteredEmail,
            _enteredPassword,
          );
          print('Registration successful: ${response['id']}');
          _navigateToLogin();
        }
      } catch (error) {
        print('Operation failed: $error');
        CustomSnackBarWidget.show(context, appLocale.operationFailed, isError: true);
      }
    }
  }

  Future<void> _navigateToHome() async {
    jumpTo(context, to: ZoomDrawerAnimation());
  }

  Future<void> _navigateToLogin() async {
    setState(() {
      _isLogin = true;
      _enteredUsernameOrEmail = '';
      _enteredEmail = '';
      _enteredPassword = '';
      _reenteredPassword = '';
      // _emailError = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 790));
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.dg),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                50.height,
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    _isLogin
                        ? appLocale.welcomeBack
                        : appLocale.createAnAccount,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).colorScheme.surface,
                          fontSize: 46.sp,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                20.height,
                if (!_isLogin) ...[
                  CustomFormFieldWidget(
                    onSaved: (value) => _enteredUsernameOrEmail = value!,
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
                    onSaved: (value) => _enteredEmail = value!,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          !value.contains('@')) {
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
                if (_isLogin) ...[
                  CustomFormFieldWidget(
                    onSaved: (value) => _enteredUsernameOrEmail = value!,
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
                  onSaved: (value) => _enteredPassword = value!,
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
                if (!_isLogin) ...[
                  20.height,
                  CustomFormFieldWidget(
                    onSaved: (value) => _reenteredPassword = value!,
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
                            fontSize: textSmall.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                if (!_isLogin) ...[
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.dg, top: 20.dg),
                    child: RichText(
                      text: TextSpan(
                        text: appLocale.byClickingThe,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.surface,
                              fontSize: textMedium.sp,
                            ),
                        children: <TextSpan>[
                          TextSpan(
                            text: appLocale.register,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: kRed,
                                  fontSize: textSmall.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          TextSpan(text: appLocale.agreeToPublicOffer),
                        ],
                      ),
                    ),
                  ),
                ],
                12.height,
                SignInSignUpButton(
                  onTap: _submit,
                  text: _isLogin ? appLocale.login : appLocale.createAccount,
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  color: kbuttoncolorColor,
                  textColor: kWhiteColor,
                  fontSize: textExtraLarge.sp,
                ),
                10.height,
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                          _form.currentState?.reset();
                          _enteredUsernameOrEmail = '';
                          _enteredEmail = '';
                          _enteredPassword = '';
                          _reenteredPassword = '';
                        });
                      },
                      child: Center(
                        child: Text.rich(
                          TextSpan(
                            text: _isLogin
                                ? appLocale.dontHaveAnAccountQSignup + " "
                                : appLocale.iAlreadyHaveAnAccount + " ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.surface,
                                  fontSize: textSmall.sp,
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
                                      color: kRed,
                                      fontSize: textSmall.sp,
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
    );
  }
}
