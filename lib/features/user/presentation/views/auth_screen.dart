import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/core/application_manager/navigation_manager.dart';
import 'package:pcnc/core/extension/sized_box_ext.dart';
import 'package:pcnc/data/app_service/api_service.dart';
import 'package:pcnc/features/user/presentation/widget/auth_actions.dart';
import 'package:pcnc/features/user/presentation/widget/auth_footer.dart';
import 'package:pcnc/features/user/presentation/widget/auth_header.dart';
import 'package:pcnc/presentation/controller/cache_controller.dart';
import 'package:pcnc/presentation/widget/drawer_widget/zoom_drawer.dart';
import 'package:pcnc/core/enum/cache_keys.dart';
import 'package:pcnc/features/user/data/repository/user_repository_impl.dart';
import 'package:pcnc/features/user/presentation/views/forgot_pass_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/features/user/presentation/widget/custom_snackbar_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
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
        final apiRepository = UserRepositoryImpl(apiService: ApiService());
        if (_isLogin) {
          final user = await apiRepository.loginUser(
            _enteredUsernameOrEmail,
            _enteredPassword,
          );
          await CacheController().setter(key: CacheKeys.token, value: user.id);
          _navigateToHome();
        } else {
          final user = await apiRepository.registerUser(
            _enteredUsernameOrEmail,
            _enteredEmail,
            _enteredPassword,
          );
          _navigateToLogin();
        }
      } catch (error) {
        CustomSnackBarWidget.show(context, appLocale.operationFailed,
            isError: true);
      }
    }
  }

  Future<void> _navigateToHome() async {
    final navManager = NavigationManager(context);
    await navManager.navigateTo(ZoomDrawerAnimation());
  }

  Future<void> _navigateToLogin() async {
    setState(() {
      _isLogin = true;
      _form.currentState?.reset();
      _enteredUsernameOrEmail = '';
      _enteredEmail = '';
      _enteredPassword = '';
      _reenteredPassword = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 790));
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.dg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AuthHeader(isLogin: _isLogin),
              20.height,
              AuthFormFields(
                isLogin: _isLogin,
                formKey: _form,
                onUsernameOrEmailSaved: (value) =>
                    _enteredUsernameOrEmail = value!,
                onEmailSaved: (value) => _enteredEmail = value!,
                onPasswordSaved: (value) => _enteredPassword = value!,
                onReenteredPasswordSaved: (value) =>
                    _reenteredPassword = value!,
              ),
              AuthActions(
                isLogin: _isLogin,
                onForgotPassword: () {
                  final navigationManager = NavigationManager(context);
                  navigationManager.replaceWith(ForgotPasswordScreen());
                },
              ),
              10.height,
              AuthFooter(
                isLogin: _isLogin,
                onSubmit: _submit,
                onToggle: () {
                  setState(() {
                    _isLogin = !_isLogin;
                    _form.currentState?.reset();
                    _enteredUsernameOrEmail = '';
                    _enteredEmail = '';
                    _enteredPassword = '';
                    _reenteredPassword = '';
                  });
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
