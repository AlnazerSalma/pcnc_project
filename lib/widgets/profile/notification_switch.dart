import 'package:pcnc/util/color_palette.dart';
import 'package:pcnc/util/theme.dart';
import 'package:pcnc/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwitchNotificationWidget extends StatefulWidget {
  @override
  _SwitchNotificationWidgetState createState() => _SwitchNotificationWidgetState();
}

class _SwitchNotificationWidgetState extends State<SwitchNotificationWidget> {
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
      onChanged: (bool value) async {
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