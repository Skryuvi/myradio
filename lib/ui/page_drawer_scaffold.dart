import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  State<DrawerPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          backgroundColor: Colors.transparent,
        ),
        child: Container());
  }
}
