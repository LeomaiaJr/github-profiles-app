import 'package:flutter/material.dart';

class User {
  bool valid = false;
  String username;
  String avatar;
  int followersCount;
  int reposCount;
  Map<int, Map<String, String>> topRepos = {};
}
// "top1": {"name": "",
//     "description": "",
//     "stargazers_count": "",
//     "forks_count": "",}
