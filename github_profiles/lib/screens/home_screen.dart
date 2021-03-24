import 'package:flutter/material.dart';
import 'package:github_profiles/widget/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String getImage(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? "github-icon.png"
        : "github-icon-white.png";
  }

  Color getInversedColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? Colors.black
        : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: height / 12,
            ),
            SizedBox(
              height: width / 3,
              child: Image.asset("assets/${getImage(context)}"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25),
              child: Text(
                "GitHub Profiles",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              child: TextField(
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: getInversedColor(context),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: getInversedColor(context),
                    ),
                  ),
                  labelText: "Username",
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).brightness == Brightness.light
                      ? Colors.blue
                      : Colors.teal,
                ),
              ),
              onPressed: () {},
              child: Text("Search"),
            )
          ],
        ),
      ),
    );
  }
}
