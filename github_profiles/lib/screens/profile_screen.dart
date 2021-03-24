import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:github_profiles/models/user.dart';

class ProfileScreen extends StatefulWidget {
  final dynamic user;
  ProfileScreen(this.user);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Item> _data;
  @override
  void initState() {
    super.initState();
    _data = generateItems(4, widget.user);
  }

  Color getColorFromTheme(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? Colors.black
        : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: height / 22),
              child: SizedBox(
                height: height / 3.5,
                child: ClipOval(
                  child: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: widget.user.avatar,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                widget.user.username,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Chip(
                  backgroundColor: getColorFromTheme(context),
                  avatar: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(
                      Icons.people,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  label: Text(
                    widget.user.followersCount.toString() + " followers",
                  ),
                  labelStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Chip(
                  backgroundColor: getColorFromTheme(context),
                  avatar: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(
                      Icons.bookmarks_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  label: Text(
                    widget.user.reposCount.toString() + " repositories",
                  ),
                  labelStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10, top: 20),
              child: Text(
                "Top 4 Repositories:",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _data[index].isExpanded = !isExpanded;
                      });
                    },
                    children: _data.map<ExpansionPanel>((Item item) {
                      return ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text(item.headerValue),
                          );
                        },
                        body: ListTile(
                            title: Text(item.description),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Chip(
                                  backgroundColor: getColorFromTheme(context),
                                  avatar: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    child: FaIcon(
                                      FontAwesomeIcons.star,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  label: Text(
                                    item.starCount + " stars",
                                  ),
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: width / 20,
                                ),
                                Chip(
                                  backgroundColor: getColorFromTheme(context),
                                  avatar: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    child: FaIcon(
                                      FontAwesomeIcons.codeBranch,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  label: Text(
                                    item.forksCount + " forks",
                                  ),
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                _data.removeWhere(
                                    (Item currentItem) => item == currentItem);
                              });
                            }),
                        isExpanded: item.isExpanded,
                      );
                    }).toList(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Item {
  Item({
    @required this.description,
    @required this.headerValue,
    @required this.starCount,
    @required this.forksCount,
    this.isExpanded = false,
  });

  String description;
  String headerValue;
  String starCount;
  String forksCount;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems, User user) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
        headerValue: user.topRepos[index]["name"],
        description: user.topRepos[index]["description"] == null
            ? "There is no description to this repository."
            : user.topRepos[index]["description"],
        starCount: user.topRepos[index]["stargazers_count"],
        forksCount: user.topRepos[index]["forks_count"]);
  });
}
