import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pcnc/core/extension/sized_box_ext.dart';
import 'package:pcnc/features/user/presentation/controller/auth_controller.dart';
import 'package:pcnc/features/user/presentation/views/forgot_pass_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/presentation/style/color_palette.dart';
import 'package:pcnc/presentation/style/font_sizes.dart';
import 'package:pcnc/presentation/widget/form_field/form_field_widget.dart';
import 'package:pcnc/presentation/widget/text_widget/custom_text.dart';
import 'package:pcnc/presentation/widget/text_widget/rich_text_widget.dart';
part '../widget/auth_actions.dart';
part '../widget/auth_footer.dart';
part '../widget/auth_form_fields.dart';
part '../widget/auth_header.dart';
part '../widget/signin_signup_widget.dart';

class AuthScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AuthHeader(isLogin: authController.isLogin.value),
                  SizedBox(height: 20),
                  AuthFormFields(
                    isLogin: authController.isLogin.value,
                    formKey: authController.formKey,
                    onUsernameOrEmailSaved: (value) =>
                        authController.enteredUsernameOrEmail.value = value!,
                    onEmailSaved: (value) =>
                        authController.enteredEmail.value = value!,
                    onPasswordSaved: (value) =>
                        authController.enteredPassword.value = value!,
                    onReenteredPasswordSaved: (value) =>
                        authController.reenteredPassword.value = value!,
                  ),
                  AuthActions(
                    isLogin: authController.isLogin.value,
                    onForgotPassword: () {
                      Get.to(() => ForgotPasswordScreen());
                    },
                  ),
                  SizedBox(height: 10),
                  AuthFooter(
                    isLogin: authController.isLogin.value,
                    onSubmit: authController.submit,
                    onToggle: authController.toggleLoginMode,
                  ),
                ],
              )),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
