import 'package:github_profiles/models/user.dart';
import 'package:github_profiles/utils/networking.dart';

class DataHandler {
  final dynamic userData;

  DataHandler(this.userData);

  Future<User> getUserData() async {
    User user = User();
    var data = this.userData;
    if (data["message"] != "Not Found") {
      NetworkHelper networkHelper = NetworkHelper();
      var repos = await networkHelper.get(data["login"] + "/repos");
      var repo = [];
      Map<int, Map<String, String>> topRepos = {};
      for (var i = 0; i < repos.length; i++) {
        repo.add(
          repos[i]["forks"] + repos[i]["stargazers_count"],
        );
      }
      var r = [...repo];
      r.sort((b, a) => a.compareTo(b));
      for (var i = 0; i < repo.length; i++) {
        if (i == 4) {
          break;
        } else {
          int index = repo.indexOf(r[i]);
          topRepos[i] = {
            "name": repos[index]["name"],
            "description": repos[index]["description"] == "null"
                ? ""
                : repos[index]["description"],
            "stargazers_count": (repos[index]["stargazers_count"]).toString(),
            "forks_count": (repos[index]["forks_count"]).toString()
          };
          repo[index] = "";
        }
      }
      user
        ..valid = true
        ..username = data["login"]
        ..avatar = data["avatar_url"]
        ..followersCount = data["followers"]
        ..reposCount = data["public_repos"]
        ..topRepos = topRepos;
      return user;
    } else {
      return user;
    }
  }
}
