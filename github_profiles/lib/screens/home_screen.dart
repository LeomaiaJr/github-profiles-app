import 'package:flutter/material.dart';
import 'package:github_profiles/widget/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String getImage(BuildContext context) {
    return Theme.of(context).primaryColor == Colors.black
        ? "github-icon.png"
        : "github-icon-white.png";
  }

  Color getInversedTheme() {
    return Theme.of(context).primaryColor == Colors.black
        ? Colors.white
        : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: getInversedTheme(),
      appBar: AppBar(
        backgroundColor: getInversedTheme(),
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
                    color: Theme.of(context).primaryColor),
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  labelStyle: TextStyle(color: Colors.red),
                  labelText: "Username",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
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
