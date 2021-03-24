import 'package:flutter/material.dart';
import 'package:github_profiles/data/theme_control.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Drawer(
      child: Column(
        children: [
          SwitchListTile(
            title: Text(
              "Settings",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            secondary:
                Icon(Icons.settings, color: Theme.of(context).primaryColor),
            value: themeChange.darkTheme,
            onChanged: (bool value) => themeChange.darkTheme = value,
          )
        ],
      ),
    );
  }
}
