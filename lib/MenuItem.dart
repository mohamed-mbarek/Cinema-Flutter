import 'package:flutter/material.dart';
import 'package:projet_cinema/ville-page.dart';

class MenuItem extends StatelessWidget {
  late String menuTitle;
  late Icon menuIcon;
  late Function handler;

  MenuItem(this.menuTitle, this.menuIcon, this.handler);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(menuTitle),
      leading: menuIcon,
      trailing: Icon(Icons.arrow_right),
      onTap: () {
        this.handler(context);
      },
    );
  }
}
