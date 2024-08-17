import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pcnc/util/color_palette.dart';
import 'package:pcnc/util/theme.dart';
import 'package:pcnc/providers/theme_provider.dart';

class SwitchThemeWidget extends StatefulWidget {
  @override
  _SwitchThemeWidgetState createState() => _SwitchThemeWidgetState();
}

class _SwitchThemeWidgetState extends State<SwitchThemeWidget> {
  late bool _value;

  @override
  void initState() {
    _value = Provider.of<ThemeProvider>(context, listen: false).themeDataStyle == ThemeDataStyle.dark;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _value,
      onChanged: (bool value) {
        setState(() {
          _value = value;
          Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
        });
      },
      activeColor: Theme.of(context).colorScheme.onBackground,
      inactiveTrackColor: kGrey2,
    );
  }
}
