import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final List<Widget> actions;
  final IconData? iconData;

  const HeaderWidget({
    Key? key,
    required this.title,
    this.backgroundColor = Colors.blue,
    this.actions = const [],
    this.iconData
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: backgroundColor,
      actions: actions,
      
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
