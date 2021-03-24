import 'package:flutter/material.dart';
import 'package:github_profiles/data/theme_control.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Drawer(
      child: DrawerHeader(
        child: Column(
          children: [
            Text("GitHub Profiles"),
            Divider(),
            SizedBox(
              height: 32,
              child: Padding(
                padding: EdgeInsets.only(left: 16, bottom: 8),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Settings',
                  ),
                ),
              ),
            ),
            SwitchListTile(
              title: Text(
                context.read<DarkThemeProvider>().darkTheme
                    ? "Dark Theme"
                    : "Light Theme",
              ),
              secondary: Icon(Icons.lightbulb),
              value: themeChange.darkTheme,
              onChanged: (bool value) => themeChange.darkTheme = value,
            )
          ],
        ),
      ),
    );
  }
}
