import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:github_profiles/screens/profile_screen.dart';
import 'package:github_profiles/utils/data_handler.dart';
import 'package:github_profiles/utils/networking.dart';
import 'package:github_profiles/widget/app_drawer.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:github_profiles/models/user.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();
  NetworkHelper networkHelper = NetworkHelper();

  bool loadingData = false;

  void getGitHubProfileData() async {
    bool result = await DataConnectionChecker().hasConnection;
    if (!result) {
      _onErorAlert(context);
    } else {
      setState(() {
        loadingData = true;
      });
      var res = await networkHelper.get(controller.text);
      DataHandler dataHandler = DataHandler(res);
      User profileUser = await dataHandler.getUserData();
      setState(() {
        loadingData = false;
      });
      if (!profileUser.valid) {
        _onInvalidUserAlert(context);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(profileUser),
          ),
        );
      }
    }
  }
  //GitHub Background Image based on theme
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
      body: ModalProgressHUD(
        inAsyncCall: loadingData,
        child: Center(
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
                  controller: controller,
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
                onPressed: getGitHubProfileData,
                child: Text("Search"),
              )
            ],
          ),
        ),
      ),
    );
  }
}


//Alerts based on Errors
_onErorAlert(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.error,
    title: "ERRO!",
    desc:
        "Hmmm... We couldn't retrive the user information, please try again later",
    buttons: [
      DialogButton(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.blue
            : Colors.teal,
        child: Text(
          "OK",
          style: TextStyle(fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        width: 120,
      )
    ],
  ).show();
}

_onInvalidUserAlert(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.error,
    title: "User Not Found!",
    buttons: [
      DialogButton(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.blue
            : Colors.teal,
        child: Text(
          "OK",
          style: TextStyle(fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        width: 120,
      )
    ],
  ).show();
}
