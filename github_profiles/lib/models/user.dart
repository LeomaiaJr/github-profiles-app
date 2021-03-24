class User {
  bool valid = false;
  String username;
  String avatar;
  int followersCount;
  int reposCount;
  Map<int, Map<String, String>> topRepos = {};
}
//Model containing all User data what will be used.