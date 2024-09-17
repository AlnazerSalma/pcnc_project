import 'package:flutter/material.dart';

class RestartApp extends StatefulWidget {
  const RestartApp({super.key, required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<RestartAppState>()!.restartApp();
  }

  @override
  RestartAppState createState() => RestartAppState();
}

class RestartAppState extends State<RestartApp> {
  Key key = UniqueKey();

  void restartApp() => setState(() => key = UniqueKey());

  @override
  Widget build(BuildContext context) =>
      KeyedSubtree(key: key, child: widget.child);
}
