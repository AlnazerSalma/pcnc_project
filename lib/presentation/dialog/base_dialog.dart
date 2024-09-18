import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/core/application_manager/navigation_manager.dart';
import 'package:pcnc/presentation/style/color_palette.dart';
import 'package:pcnc/presentation/widget/text_widget/custom_text.dart';

abstract class BaseDialog extends StatelessWidget {
  const BaseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    final navigationManager = NavigationManager(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      content: buildContent(context),
      actions: [
        TextButton(
          onPressed: () {
             navigationManager.popScreen();
          },
          child: CustomText(text: 
            appLocale.close,
            color:kbuttoncolorColor,
          ),
        ),
      ],
    );
  }

  Widget buildContent(BuildContext context);
}
